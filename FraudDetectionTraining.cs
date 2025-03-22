using System;
using System.IO;
using BREACH_TECHNOVAS;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Transforms;

public class FraudDetectionTraining
{
    private static readonly string ModelPath = "MLModel.zip";

    public static void TrainModel()
    {
        var context = new MLContext();

        // Load data from CSV (ensure proper column mappings)
        IDataView data = context.Data.LoadFromTextFile<TransactionData>(
            path: "D:\\MyASM\\BREACH_TECHNOVAS\\BREACH_TECHNOVAS\\App_Data\\creditcard.csv",
            separatorChar: ',',
            hasHeader: true);

        // Data preprocessing: Replace missing Location values with "Unknown"
        var pipeline = context.Transforms.Conversion.ConvertType("Label", "IsFraud", DataKind.Boolean)
            .Append(context.Transforms.ReplaceMissingValues("Location", replacementMode: MissingValueReplacingEstimator.ReplacementMode.DefaultValue))
            .Append(context.Transforms.Text.FeaturizeText("LocationFeaturized", "Location")) // Convert text into numerical features
            .Append(context.Transforms.Concatenate("Features", "Amount", "TransactionTime", "LocationFeaturized", "DeviceType"))
            .Append(context.BinaryClassification.Trainers.SdcaLogisticRegression());

        // Train the model
        var model = pipeline.Fit(data);

        // Save the trained model
        context.Model.Save(model, data.Schema, ModelPath);
        Console.WriteLine("Model training complete! 🚀");
    }

    public static bool PredictFraud(TransactionData input)
    {
        var context = new MLContext();
        ITransformer model = context.Model.Load(ModelPath, out var _);
        var engine = context.Model.CreatePredictionEngine<TransactionData, TransactionPrediction>(model);

        return engine.Predict(input).IsFraud;
    }

    internal static bool PredictFraud(BREACH_TECHNOVAS.TransactionData transaction)
    {
        return false;
    }
}
