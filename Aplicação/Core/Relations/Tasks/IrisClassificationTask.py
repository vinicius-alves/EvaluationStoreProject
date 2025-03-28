from ..Task import *
from ..TaskType import *
from ..MeasureProcedures import AccuracyMeasureProcedure
from sklearn.model_selection import train_test_split

class IrisClassificationTask(Task):

   
    def __init__(self,   dataset= None):
        self.taskType = TaskType(idTaskType = 1)
        self.name = 'IrisClassificationTask'
        self.dataset = dataset
        measureProcedure = AccuracyMeasureProcedure()
        self.measureProcedures = [measureProcedure]


    def execute(self, model, taskParameters):

        df = self.dataset.df
        targetFeature = self.dataset.targetFeature
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
    
    