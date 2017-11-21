"""lmsimpacta URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from core.views import *

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$', index),
    url(r'^areaaluno/$', areaaluno),
    url(r'^areaprofessor/$', areaprofessor),
    url(r'^aulaslp/$', aulaslp),
    url(r'^aulassql/$', aulassql),
    url(r'^aulastecweb/$', aulastecweb),
    url(r'^codigo/$', codigo),
    url(r'^editperfilaluno/$', editperfilaluno),
    url(r'^editperfilprof/$', editperfilprof),
    url(r'^editsenhaaluno/$', editsenhaaluno),
    url(r'^editsenhaprof/$', editsenhaprof),
    url(r'^formprof/$', formprof),
    url(r'^matricula/$', matricula),
    url(r'^notasefaltasaluno/$', notasefaltasaluno),
    url(r'^notasefaltasprofessor/$', notasefaltasprofessor),
    url(r'^perfilaluno/$', perfilaluno),
    url(r'^perfilprof/$', perfilprof),
    url(r'^satividades/$', satividades),
    url(r'^smartclass/$', smartclass),
    url(r'^smartclassprofessor/$', smartclassprofessor),
    url(r'^smartProf/$', smartProf),
    url(r'^solicitardisciplina/$', solicitardisciplina),
    url(r'^trabalhos/$', trabalhos),
]