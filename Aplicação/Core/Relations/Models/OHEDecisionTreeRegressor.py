
from ..Model import Model 
from ..Parameter import Parameter
from ..ParameterType import ParameterType
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.tree import DecisionTreeRegressor 
import sklearn 

class OHEDecisionTreeRegressor(Model):

    def __init__(self, categorical_cols): 
        self.name = type(self).__name__
        self.version = sklearn.__version__

        # Pré-processamento com OneHotEncoder
        preprocessor = ColumnTransformer(
            transformers=[
                ("cat", OneHotEncoder(handle_unknown="ignore", sparse_output=False), categorical_cols)
            ],
            remainder="passthrough"
        )

        # Pipeline com DecisionTreeRegressor
        self.model = Pipeline(steps=[
            ("preprocessor", preprocessor),
            ("regressor", DecisionTreeRegressor(random_state=42))
        ])
    
    def fit(self,X,y):
        self.model.fit(X,y)
        self.serialize()
    
    def predict(self,X):
        return self.model.predict(X)
        
    def predict_proba(self,X):
        return self.model.predict_proba(X)
    
    def set_params(self,params):
        self.model.named_steps['regressor'].set_params(**params)
        self.serialize()

    def get_params(self):
        params = self.model.get_params()
        lst_parameters = []
        for key, value in params.items():
            if key != 'steps':
                modelParameter = Parameter(name = key, value = value)
                modelParameter.parameterType = ParameterType(idParameterType = 1,name = 'Model')
                modelParameter.process_type()
                lst_parameters.append(modelParameter)
        return lst_parameters