from django.shortcuts import render

def index(request):
    return render(request,"index.html")

def areaaluno(request):
    return render(request,"areaaluno.html")

def areaprofessor(request):
    return render(request,"areaprofessor.html")

def aulaslp(request):
    return render(request,"aulaslp.html")

def aulassql(request):
    return render(request,"aulassql.html")

def aulastecweb(request):
    return render(request,"aulastecweb.html")

def codigo(request):
    return render(request,"codigo.html")

def editperfilaluno(request):
    return render(request,"editperfilaluno.html")

def editperfilprof(request):
    return render(request,"editperfilprof.html")

def editsenhaaluno(request):
    return render(request,"editsenhaaluno.html")

def editsenhaprof(request):
    return render(request,"editsenhaprof.html")

def formprof(request):
    return render(request,"formprof.html")

def notasefaltasaluno(request):
    return render(request,"notasefaltasaluno.html")

def notasefaltasprofessor(request):
    return render(request,"notasefaltasprofessor.html")

def perfilaluno(request):
    return render(request,"perfilaluno.html")

def perfilprof(request):
    return render(request,"perfilprof.html")

def satividades(request):
    return render(request,"satividades.html")

def smartclass(request):
    return render(request,"smartclass.html")

def smartclassprofessor(request):
    return render(request,"smartclassprofessor.html")

def smartProf(request):
    return render(request,"smartProf.html")

def solicitardisciplina(request):
    return render(request,"solicitardisciplina.html")

def matricula(request):
    return render(request,"trabalhos.html")

