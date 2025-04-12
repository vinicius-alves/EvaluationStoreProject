from ..Task import *
from ..TaskType import * 
from sklearn.model_selection import train_test_split
from ..MeasureProcedures import RMSEMeasureProcedure

class SeoulBikeTrainingTask(Task):

   
    def __init__(self,   dataset= None):
        self.taskType = TaskType( idTaskType = 2,type = 'Training')
        self.name = type(self).__name__
        self.dataset = dataset
        measureProcedure = RMSEMeasureProcedure()
        self.measureProcedures = [measureProcedure]


    def execute(self, model, parameters):

        df = self.dataset.df
        targetFeature = self.dataset.targetFeature  

        model.set_categorical_cols(['seasons', 'holiday', 'functioning_day'])

        if type(parameters) == dict:
            if 'end_date' in parameters.keys():
                df = df[df['timestamp']<parameters['end_date']].reset_index(drop = True)

        df = df.drop(columns = ['timestamp'], errors = 'ignore')

        y = df[targetFeature]
        X = df.drop(columns=[targetFeature])

        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

        model.fit(X_train, y_train)
        y_pred = model.predict(X_test)
        measures = []
        for measureProcedure in self.measureProcedures:
            measure = measureProcedure.evaluate(y_truth = y_test, y_pred = y_pred)
            measures.append(measure)

        return measures
    
    