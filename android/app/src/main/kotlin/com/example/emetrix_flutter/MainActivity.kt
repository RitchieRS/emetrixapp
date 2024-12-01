package com.example.emetrix_flutter


import io.flutter.embedding.android.FlutterActivity

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.tensorflow.lite.Interpreter
import org.tensorflow.lite.support.label.Category
import org.tensorflow.lite.support.label.TensorLabel
import org.tensorflow.lite.support.tensorbuffer.TensorBuffer
import org.tensorflow.lite.support.tensorbuffer.TensorBuffer.createFixedSize
import java.io.FileInputStream
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.nio.channels.FileChannel


class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var model: Interpreter

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "tflite_classifier")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method == "classifyImage") {
            val imagePath = call.argument<String>("imagePath")
            if (imagePath != null) {
                model = Interpreter(loadModelFile("model_classifier.tflite"))
                val bitmap = loadBitmap(imagePath)
                val top5Categories = classifyImage(bitmap, model)

                val resultList = mutableListOf<CategoryResult>()
                top5Categories.forEach { category ->
                    resultList.add(CategoryResult(category.label, category.score))
                }

                val resultMap = mutableMapOf<String, Float>()
                resultList.forEach { categoryResult ->
                    resultMap[categoryResult.label] = categoryResult.score
                }

                result.success(resultMap)
            } else {
                result.error("INVALID_ARGUMENT", "Image path is null", null)
            }
        } else {
            result.notImplemented()
        }
    }

    private fun loadModelFile(modelPath: String): ByteBuffer {
        val assetFileDescriptor = assets.openFd(modelPath)
        val fileInputStream = FileInputStream(assetFileDescriptor.fileDescriptor)
        val fileChannel = fileInputStream.channel
        val startOffset = assetFileDescriptor.startOffset
        val declaredLength = assetFileDescriptor.declaredLength
        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength)
    }

    private fun classifyImage(bitmap: Bitmap, model: Interpreter): List<Category> {
        return try {
            val resizedBitmap = Bitmap.createScaledBitmap(bitmap, 640, 640, true)
            val inputImageBuffer = convertBitmapToByteBuffer(resizedBitmap)

            val probabilityBuffer = createFixedSize(intArrayOf(1, 93), org.tensorflow.lite.DataType.FLOAT32)

            model.run(inputImageBuffer, probabilityBuffer.buffer.rewind())

            val labels = assets.open("labels_classifier.txt").bufferedReader().useLines { it.toList() }

            val labeledProbability = TensorLabel(labels, probabilityBuffer).mapWithFloatValue

            labeledProbability.entries
                .map { Category(it.key, it.value) }
                .sortedByDescending { it.score }
                .take(5)
        } catch (e: Exception) {
            Log.e("Classifier_log", "Error clasificando la imagen: ${e.message}", e)
            emptyList() // Retorna una lista vacía en caso de error
        }
    }

    private fun convertBitmapToByteBuffer(bitmap: Bitmap): ByteBuffer {
        val byteBuffer = ByteBuffer.allocateDirect(4 * 640 * 640 * 3)
        byteBuffer.order(ByteOrder.nativeOrder())
        val intValues = IntArray(640 * 640)
        bitmap.getPixels(intValues, 0, bitmap.width, 0, 0, bitmap.width, bitmap.height)
        var pixel = 0
        for (i in 0 until 640) {
            for (j in 0 until 640) {
                val value = intValues[pixel++]
                byteBuffer.putFloat(((value shr 16) and 0xFF) / 255.0f)
                byteBuffer.putFloat(((value shr 8) and 0xFF) / 255.0f)
                byteBuffer.putFloat((value and 0xFF) / 255.0f)
            }
        }
        return byteBuffer
    }

    private fun loadBitmap(imagePath: String): Bitmap {
        val inputStream = FileInputStream(imagePath)
        return BitmapFactory.decodeStream(inputStream)
    }
}

data class CategoryResult(val label: String, val score: Float)
