<template>
    <div id="navbar">
        <nav id="navbarMain" class="navbar navbar-expand-md navbar-dark fixed-top">
            <a class="navbar-brand" href="#">Lucidify</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                </ul>
                <a v-if="!loggedOn()" href="https://accounts.spotify.com/authorize?client_id=95478a94ff504770b31f32821ad73a45&redirect_uri=https://api.lucidi.fi/v1/login&scope=user-read-email%20user-read-private%20user-read-birthdate%20user-read-recently-played&response_type=code" class="btn my-2 my-sm-0" id="login"><span style="padding: 2px">Login with Spotify</span><i class="fa fa-spotify" aria-hidden="true" style="padding: 5px"></i></a>
                <div v-if="loggedOn()" id="loggedIn" class="my-2 my-sm-0">Logged in as {{ email }}</div>
                <button v-if="loggedOn()" class="btn" id="logout" v-on:click="logOut()">Log Out</button>
            </div>
        </nav>
    </div>
</template>

<script>
import cookie from "cookie";
export default {
  name: "navbar",
  data() {
    return {
      email: ""
    };
  },

  methods: {
    loggedOn() {
      if (cookie.parse(document.cookie).access_token) {
        axios({
          method: "get",
          url: "https://api.spotify.com/v1/me",
          headers: {
            Authorization:
              "Bearer " + cookie.parse(document.cookie).access_token
          }
        }).then(
          function(response) {
            this.email = response.data.email;
          }.bind(this)
        );
        return true;
      }
      return false;
    },

    logOut() {
      document.cookie =
        "access_token='';expires=" +
        new Date(new Date().getTime()).toUTCString();
      document.cookie =
        "refresh_token='';expires=" +
        new Date(new Date().getTime()).toUTCString();
      window.location = "https://www.lucidi.fi";
    }
  }
};
</script>

<style scoped>
#navbarMain {
  border-bottom: 2px solid;
  -webkit-box-shadow: 0 8px 10px -2px;
}

.navbar {
  background-color: darkgreen;
  height: 45px;
}

#loggedIn {
    color: white;
    padding-right: 10px;
}

#login {
  background-color: green;
  color: white;

  font-size: 15px;
  text-align: center;
}

#logout {
  top: 12%;
  bottom: 12%;
  right: 1%;
  background-color: green;
  color: white;
  margin-left: 1%;
}
</style>
