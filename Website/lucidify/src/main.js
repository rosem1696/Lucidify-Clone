
import Vue from 'vue'
import Vuetify from 'vuetify'
import BootstrapVue from 'bootstrap-vue'
import qs from 'qs'
import App from './app.vue'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify);
Vue.use(BootstrapVue);

function onLoad() {
  var queryString = window.location.search.substr(1);
  var qstringParsed = qs.parse(queryString);
  var redirect = qstringParsed.access_token;

  if (qstringParsed.access_token) {
    document.cookie = "access_token=" + qstringParsed.access_token + "; expires=" + new Date(new Date().getTime() + 3600 * 1000).toUTCString();
  }

  if (qstringParsed.refresh_token) {
    document.cookie = "refresh_token=" + qstringParsed.refresh_token;
  }

  if (redirect) {
    document.location = "http://www.lucidi.fi"
  }
}

onLoad();

var nb = new Vue({
  el: "#app",
  render: h => h(App),
  date: {
    username: ""
  }
});
