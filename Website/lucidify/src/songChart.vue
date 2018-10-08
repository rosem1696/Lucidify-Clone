<template>
  <div id="songChart" class="fill-parent">
    <b-container fluid class="fill-parent">
      <b-row align-v="center" align-h="center">
        <b-img :src="imageLink" center width="300" blank-color="#bbb" alt="img" class="my-5" />
      </b-row>
      <b-row align-v="center" align-h="center">
        <div class="artist-description"><h1>{{ name }} | {{ songs.length + (songs.length === 1 ? " song" : " songs") }}</h1></div>
        <div class="artist-description"><h2></h2></div>
      </b-row>
      <b-row align-v="center" align-h="center">
        <div id="songs-table-container">
          <b-table striped hover dark :items="songs" id="songs-table"></b-table>
        </div>
      </b-row>
    </b-container>
  </div>
</template>

<script>
export default {
  name: "songChart",
  data () {
    return {
      data: "",
      songs: "",
      imageLink: "",
      name: ""
    }
  },
  props: ['artist'],
  methods: {
    renderChart: function(data, component) {
      this.$data.imageLink = data.picture_url;
      var songs = data.songs
      this.$data.songs = [];
      this.$data.name = data.name;


      for(var i = 0; i < songs.length; i++) {
          var time = new Date(songs[i].listened_at * 1000);
          time = this.formatDate(time);
          this.$data.songs.push({song_name: songs[i].name, times_listened: songs[i].num_times_listened, last_listened: time});
        }
      },

      formatDate: function(date) {
        var monthNames = [
          "January", "February", "March",
          "April", "May", "June", "July",
          "August", "September", "October",
          "November", "December"
        ];
        var day = date.getDate();
        var monthIndex = date.getMonth();
        var year = date.getFullYear();

        return day + ' ' + monthNames[monthIndex] + ' ' + year;
        }
      },

  watch: {
    artist: function(val) {
      $("#songChart #table").remove();
      this.renderChart(val, this);
    }
  }
};
</script>


<style>
.song-content {
  display: flex;
  align-items: center;
}

.fill-parent {
  height: 100%
}

#songs-table-container {
  height: 400px;
  overflow: auto;
}

.artist-description {
  color: white;
  text-align: center;
}
</style>
