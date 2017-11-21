from django import forms

from core.models import Curso

class CursoForm(forms.ModelForm):
 
    class Meta:
        model = Curso
        fields = "__all__"

class ContatoForm(forms.form):        

    nome = forms.CharField()
    email = forms.EmailField() 
    mensagem = forms.Charfield()

    def envia_email(self):
        print(
            "Email Para você:\n "+
            "Aluno: "+self.cleaned_data["nome"]+"\n"+
            "Email: "+self.cleaned_data["email"]+"\n"+
            "Mensagem: "+self.cleaned_data["mensagem"]
        )
          
