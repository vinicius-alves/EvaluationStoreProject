from .DatabaseManager import *
from sqlalchemy import  Column, Integer, String, LargeBinary
from sqlalchemy.orm import relationship

class ModelDTO(Base):
    __tablename__ = 'Model'

    idModel = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(256), nullable=True)
    version = Column(String(256), nullable=True)
    object = Column(LargeBinary, nullable=True)

    runs = relationship('RunDTO', back_populates='model')

    def __init__(self, name = None, version = None, model = None, object = None, idModel = None):
        self.idModel = idModel
        self.name = name
        self.version = version
        self.object = object
        self.model = model


class ModelRepository(GenericRepository):
    def __init__(self, session):
        super().__init__(session, ModelDTO)