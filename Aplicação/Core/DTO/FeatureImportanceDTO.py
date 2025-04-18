from .DatabaseManager import *
from sqlalchemy import  Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship 


class FeatureImportanceDTO(Base):
    __tablename__ = 'FeatureImportance' 

    idFeatureImportance = Column(Integer, primary_key=True, autoincrement=True)
    feature = Column(String(45), nullable=True)
    importance = Column(String(45), nullable=True)

    idModel = Column(Integer, ForeignKey('Model.idModel'), nullable=True)
    model = relationship('ModelDTO', back_populates='featureImportances') 

    def __init__(self, importance=None, idFeatureImportance=None, feature= None):
        self.idFeatureImportance = idFeatureImportance
        self.importance = importance
        self.feature = feature


class FeatureImportanceRepository(GenericRepository):
    def __init__(self, session):
        super().__init__(session, FeatureImportanceDTO)
 