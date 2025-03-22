using Microsoft.ML.Data;

namespace BREACH_TECHNOVAS
{
    public class TransactionData
    {
        [LoadColumn(0)] public float Amount { get; set; }
        [LoadColumn(1)] public string TransactionTime { get; set; }
        [LoadColumn(2)] public string Location { get; set; }
        [LoadColumn(3)] public string DeviceType { get; set; }
        [LoadColumn(4)] public bool IsFraud { get; set; }
    }

    public class TransactionPrediction
    {
        [ColumnName("PredictedLabel")] public bool IsFraud { get; set; }
    }
}