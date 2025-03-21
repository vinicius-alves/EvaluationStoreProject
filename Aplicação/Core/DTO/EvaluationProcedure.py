from .DatabaseManager import *
from sqlalchemy import  Column, Integer, String, LargeBinary

class EvaluationProcedure(Base):
    __tablename__ = 'evaluationprocedure'

    idEvaluationProcedure = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(255), nullable=False)
    object = Column(LargeBinary, nullable=True)

    def __init__(self, name, object = None, idEvaluationProcedure = None):
        self.idEvaluationProcedure = idEvaluationProcedure
        self.name = name
        self.object = object

    def evaluate(self, **kwargs):
        raise NotImplementedError('Base class method')

  
class EvaluationMeasureRepository(GenericRepository):
    def __init__(self, session):
        super().__init__(session, EvaluationProcedure)