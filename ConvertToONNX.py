import joblib
import skl2onnx
from skl2onnx.common.data_types import FloatTensorType


# Load models
scaler = joblib.load("scaler.pkl")
knn = joblib.load("knn_model.pkl")

# Define input shape
initial_type = [("input", FloatTensorType([None, knn.n_neighbors]))]

# Convert to ONNX
onnx_model = skl2onnx.convert_sklearn(knn, initial_types=initial_type)

# Save
with open("knn_model.onnx", "wb") as f:
    f.write(onnx_model.SerializeToString())

print("Model converted to ONNX.")
