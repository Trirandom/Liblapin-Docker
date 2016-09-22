
Voici un Dockfile qui permet d'utiliser la liblapin : 
(Testé en 1.8 avec le raytracer)

La liblapin n'est volontairement pas inclu dans ce repository, 
vous la trouverez dans le repository : Damdoshi/LibLapin. (n'étant plus diponible sur l'intranet)
Il vous suffira alors de renommer le dossier : "liblapin"

Aussi le driver graphique de mon ordinateur n'est probablement pas le même que le votre.
Veillez à modifier le nom dans le docker file.
Je l'ai laissé à titre d'exemple
(je ferais possiblement une maj avec le driver du hp-elitbook 840)

Vous pouvez maintenant docker build l'image

Je run les images comme suis : 
sudo docker run --rm \
       --env DISPLAY="${DISPLAY}" \
       --volume /tmp/.X11-unix:/tmp/.X11-unix \
       --privileged \
       --name gfx-raytracer raytracer


