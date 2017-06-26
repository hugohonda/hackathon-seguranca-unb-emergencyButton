<template>
  <div class="home">
    <h1>{{ title }}</h1>
    <div class="cards-container">
      <div class="map-card-square card-square mdl-card mdl-shadow--4dp">
        <div class="mdl-card__title mdl-card--expand">
          <div class="mapFrame">
            <iframe
              width="1000"
              height="400"
              frameborder="0" style="border:0"
              src="https://www.google.com/maps/embed/v1/place?key=AIzaSyA_sBcEu8xEWXmfVEBDjzal8FK7ysSsss8&q=pat+unb&center=-15.7588263,-47.8708275&zoom=18">
            </iframe>
          </div>
        </div>
        <div class="mdl-card__supporting-text">
          Latitude: {{ latitude }}<br>
          Longitude: {{ longitude }}
        </div>
        <div class="mdl-card__actions mdl-card--border">
          <a href="https://www.google.com.br/maps/place/15%C2%B045'31.8%22S+47%C2%B052'15.0%22W/@-15.7588263,-47.8730162,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d-15.7588263!4d-47.8708275&zoom=30" target="_blank" class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">
            ver localização atual
          </a>
        </div>
      </div>

      <div class="log-card-square card-square mdl-card mdl-shadow--4dp">
        <div class="log-list__title">Registro</div>
        <div class="mdl-card__title mdl-card--expand">
          <div class="log-list__container">
            <div class="log-list__item">
              <i class="material-icons mdl-list__item-avatar">error_circle</i>
              <span class="mdl-list__item-primary-content">
                <span>Estado de alerta</span>
                <br>
                <span class="mdl-list__item-text-body">
                  Trecho: -15.7626526,-47.8703838<br>-15.7681074,-47.8754182<br><a href="https://www.google.com.br/maps/dir/-15.7626526,-47.8703838/-15.7681074,-47.8754182/@-15.7663341,-47.8773305,16z/data=!4m3!4m2!3e2!5i1" target="_blank">ver no mapa</a>
                </span>
              </span>
              <span class="mdl-list__item-secondary-content">
                <a class="mdl-list__item-secondary-action" href="#"><i class="material-icons">star</i></a>
              </span>
            </div>
            <div class="log-list__item">
              <i class="material-icons mdl-list__item-avatar">check_circle</i>
              <span class="mdl-list__item-primary-content">
                <span>Trecho seguro</span>
              </span>
              <span class="mdl-list__item-secondary-content">
                <a class="mdl-list__item-secondary-action" href="#"><i class="material-icons">star</i></a>
              </span>
            </div>
            <div class="log-list__item">
              <i class="material-icons mdl-list__item-avatar">warning</i>
              <span class="mdl-list__item-primary-content">
                <span>Pânico</span>
                <br>
                <span class="mdl-list__item-text-body">
                  Trecho: -15.7626526,-47.8703838<br>-15.7681074,-47.8754182<br><a href="https://www.google.com.br/maps/dir/-15.7626526,-47.8703838/-15.7681074,-47.8754182/@-15.7663341,-47.8773305,16z/data=!4m3!4m2!3e2!5i1" target="_blank">ver no mapa</a>
                </span>
              </span>
              <span class="mdl-list__item-secondary-content">
                <a class="mdl-list__item-secondary-action" href="#"><i class="material-icons">star</i></a>
              </span>
            </div>
            <div class="log-list__item">
              <i class="material-icons mdl-list__item-avatar">error_circle</i>
              <span class="mdl-list__item-primary-content">
                <span>Estado de alerta</span>
                <br>
                <span class="mdl-list__item-text-body">
                  Trecho: -15.7626526,-47.8703838<br>-15.7681074,-47.8754182<br><a href="https://www.google.com.br/maps/dir/-15.7626526,-47.8703838/-15.7681074,-47.8754182/@-15.7663341,-47.8773305,16z/data=!4m3!4m2!3e2!5i1" target="_blank">ver no mapa</a>
                </span>
              </span>
              <span class="mdl-list__item-secondary-content">
                <a class="mdl-list__item-secondary-action" href="#"><i class="material-icons">star</i></a>
              </span>
            </div>
            <div class="log-list__item">
              <i class="material-icons mdl-list__item-avatar">check_circle</i>
              <span class="mdl-list__item-primary-content">
                <span>Trecho seguro</span>
              </span>
              <span class="mdl-list__item-secondary-content">
                <a class="mdl-list__item-secondary-action" href="#"><i class="material-icons">star</i></a>
              </span>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script>
export default {
  name: 'home',
  data () {
    return {
      title: 'alert.me',
      latitude: '-15.7588263',
      longitude: '-47.8708275',
      myKey: 'AIzaSyA_sBcEu8xEWXmfVEBDjzal8FK7ysSsss8'
    }
  }
}
</script>

<style lang="scss" scoped>
h1, h2 {
  font-weight: normal;
}

.home {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  background-image: url('../assets/william-stitt-125253.jpg') center / cover;
  width: 100vw;
  height: 100vh;
}

.cards-container {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  padding-top: 1em;
}

.card-square.mdl-card {
  display: flex;
  flex-grow: 1;
  min-width: 26em;
  min-height: 25em;
  margin: 1em;
}

.map-card-square > .mdl-card__title {
  color: #333;
}

.mapFrame {
  display: flex;
  align-self: stretch;
  min-width: 24em;
}

.log-list__title {
  display: flex;
  align-self: center;
  padding-top: 2em;
  font-weight: 600;
  font-size: 1.2em;
}

.log-list__container {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  min-width: 24em;
  overflow-y: auto;
}

.log-list__item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-left: 1em;
  margin-right: 1em;
  margin-top: 1em;
}

</style>
