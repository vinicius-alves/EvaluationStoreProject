class Task():


    def __init__(self):
        raise NotImplementedError('Classe abstrata')


    def execute(self, model, parameters):
        raise NotImplementedError('Classe abstrata')
    
    def set_target_feature_name(self, target_feature_name):
        self.target_feature_name = target_feature_name

