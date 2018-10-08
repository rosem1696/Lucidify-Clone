<template>

<div id="graph-container">
<div id="background"></div>
  <b-container fluid>
    <b-row align-h="center" align-v="center">

      <b-col cols="2" >
        <v-stepper class="transparentBackground" id="stepper" vertical>
          <v-stepper-step  complete-icon="" v-on:click.native="showGenreGraph" :complete="!hideGenres">Your Music</v-stepper-step>
          <v-stepper-step  complete-icon="" :class="{'hidden' : hideArtistStepper}" v-on:click.native="showArtistGraph" :complete="!hideArtists">{{currentGenre}}</v-stepper-step>
          <v-stepper-step  complete-icon="" :class="{'hidden' : hideSongStepper}" v-on:click.native="showSongsGraph" :complete="!hideSongs">{{currentArtist}}</v-stepper-step>
        </v-stepper>
      </b-col>

      <b-col cols="8">
        <div :class="{'hidden' : hideGenres}" >
          <bubbleChart  @genreClick="genreClick" @loaded="showSurveyLink"></bubbleChart>
        </div>
        <div :class="{'hidden' : hideArtists}" >
          <artistGraph  @artistClick="artistClick"  :artistData="artistData"></artistGraph>
        </div>
        <div :class="{'hidden' : hideSongs}" >
          <songChart  :artist="artist"></songChart>
        </div>
        <div id="survey">Thanks for checking out Lucidify! Want to help make it even better?<br>Fill out our short <a id="survey-link" href="https://goo.gl/forms/6IjKJKqdvH5viEDo2">survey</a> on your experience. We appreciate the feedback!</div>
      </b-col>

      <b-col cols="2">

      </b-col>


    </b-row>
  </b-container>

</div>
</template>

<script>
import BubbleChart from "./bubbleChart.vue";
import ArtistGraph from "./artistGraph.vue";
import SongChart from "./songChart.vue";

export default {
  name: "graphView",
  data() {
    return {
      data: "",
      artistData: "",
      artist: "",
      hideGenres: false,
      hideArtists: true,
      hideSongs: true,
      hideArtistStepper: true,
      hideSongStepper: true,
      currentGenre: "",
      currentArtist: ""

    };
  },
  components: {
    bubbleChart: BubbleChart,
    artistGraph: ArtistGraph,
    songChart: SongChart
  },
  methods: {
    genreClick: function(data){
      this.artistData = data;
      this.hideGenres = true;
      this.hideArtists = false;
      this.hideArtistStepper = false;
      this. currentGenre = data.name;
    },

    artistClick: function(data) {
      this.artist = data;
      this.hideArtists = true;
      this.hideSongs = false;
      this.hideSongStepper = false;
      this.currentArtist = data.name;
    },

    showGenreGraph: function(){
      this.hideArtists = true;
      this.hideGenres = false;
      this.hideSongs = true;
      this.hideArtistStepper = true;
      this.hideSongStepper = true;
    },

    showArtistGraph: function(){
      this.hideSongs = true;
      this.hideGenres = true;
      this.hideArtists = false;
      this.hideSongStepper = true;
    },

    showSongsGraph: function(){
      this.hideSongs = false;
      this.hideGenres = true;
      this.hideArtists = true;
    },

    showSurveyLink: function() {
      $('#survey').removeClass('hidden');
    }
  },

  mounted(){
    $("#artist-back-button").addClass("hidden");
    $("#song-back-button").addClass("hidden");
  }
};
</script>


<style scoped>

body, html {
  height: 100%;

}

#background {
  z-index: -1;
  background-image: url('https://static.pexels.com/photos/63703/pexels-photo-63703.jpeg');
  background-size: cover;
  position: fixed;
  height: 100%;
  width: 100%;
  transform: scale(1.02);

  -webkit-filter: blur(5px) brightness(30%);
  -webkit-opacity: 0.85;

}

#survey {
  color: white;
  padding-top: 2%;
  text-align: center;
}

#survey-link {
  color: rgb(34, 170, 153);
}

#survey-link:hover {
  color: darkcyan;
}

#graph-container {
  padding-top: 45px;

}

#stepper {
  border: none;
  box-shadow: none;
  padding-bottom: 0;
}

.stepper {
  cursor: pointer;
  color: transparent;
}
.transparentBackground {
  background: transparent !important;
  background-color: transparent !important;
  color: transparent !important;
}


.hidden {
  visibility: hidden;
  display: none
}

.hidden-not-gone {
  visibility: hidden;
}

.main-content {
  height: 800px
}

#breadcrumb-text {
  color: white;
  text-align: center
}

#breadcrumb {
  padding-top: 15px;
}
</style>
