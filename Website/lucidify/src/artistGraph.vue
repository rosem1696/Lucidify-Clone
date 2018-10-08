<template>
<div id="artistChart" class="chart" width="1000" height="1000"></div>
</template>

<script>
import cookie from "cookie";
import colors from "./colors.js"
import * as d3 from "d3";
import * as d3_chromatic from "d3-scale-chromatic";
import * as textwrap from "d3-textwrap";
import * as d3Selection from "d3-selection";
import "d3-extended";
import stringHash from "string-hash";
import tippy from "tippy.js";

export default {
  name: "artistChart",
  data() {
    return {
      data: "",
      initialize: false
    };
  },

  props: ['artistData'],

  methods: {
    click: function() {
      this.$emit("click");
    },

    renderChart: function(data, component) {
      function getColor(data) {
        var color_array = colors.colors;
        var hash = stringHash(data);
        return color_array[hash % color_array.length];
      }

      var diameter = 800,
        format = d3.format(",d");

      var mouseEnterZoom = function() {
        d3.select(this.parentNode).moveToFront();
        var item = d3.select(this);
        if (item.attr("r") < 40){
          item.attr("prevr", item.attr("r"));
          item.interrupt();
          item.transition().ease(d3.easeLinear).duration(100).attr("r", item.attr("r") * 1 + 30);
        }
      };

      var clicker = function() {
        var artist = d3.select(this).datum();
        component.$emit("artistClick", artist);
      };

      var mouseLeaveZoom = function() {
        var item = d3.select(this);
        item.interrupt();
        if (item.attr("prevr")){
          item.attr("r", item.attr("prevr"));
        }
      };

      var bubble = d3
        .pack()
        .size([diameter, diameter])
        .padding(1.5);

      var svg = d3
        .select("#artistChart")
        .append("svg")
        .attr("width", diameter)
        .attr("height", diameter)
        .attr("class", "bubble")
        .attr("id", "bubbles")
        .style("overflow", "visible");

      function makeFlat(root) {
        var nodeThings = [];

        function recurse(name, node) {
          if (node.artists)
            node.artists.forEach(function(child) {
              recurse(node.name, child);
            });
          else nodeThings.push({ name: node.name, size: node.songs.length, songs: node.songs, detail_url: node.artist_detail_url, picture_url: node.artist_picture_url  });
        }

        recurse(null, root);
        return { children: nodeThings };
      }

      var root = d3
        .hierarchy(makeFlat(data))
        .sum(function(d) {
          return d.size;
        })
        .sort(function(a, b) {
          return b.size - a.size;
        });

      bubble(root);

      var node = svg
        .selectAll(".node")
        .data(root.children)
        .enter()
        .append("g")
        .attr("class", "node")
        .attr("title", function(d) { return d.data.name + "<br>" + d.data.size + (d.data.size === 1 ? " song" : " songs"); })
        .attr("transform", function(d) {
          return "translate(" + d.x + "," + d.y + ")";
        });


      node
        .append('defs')
        .append('pattern')
        .attr('id', function(d){ return d.data.name.replace(/ /g, '-') + '-image'; })
        .attr('width', function(d){ return 1; })
        .attr('height', function(d){ return 1; })
        .append('image')
        .attr('xlink:href', function(d){ return d.data.picture_url; })
        .attr('x', 0)
        .attr('y', 0)
        .attr('width', function(d){ return d.r*2; })
        .attr('height', function(d){ return d.r*2; });

      node
        .append("circle")
        .attr("r", function(d) {
          return d.r;
        })
        .style("fill", "black")
        .on("click", clicker);

      node
        .append("circle")
        .attr("r", function(d) {
          return d.r;
        })
        .style("fill", function(d) {
          return "url(#" + d.data.name.replace(/ /g, '-') + "-image)";
        })
        .datum(function(d) {
          return d.data;
        })
        .on("click", clicker);

      d3.selectAll("circle")
        .each(function (d, i){
          var el = d3.select(this)
          if (el.attr("r") < 40) {
            d3.select(this.parentNode)
              .attr("class", "node small-bubble");
          }
        });

      tippy('[title]', { followCursor: true, duration: '0', arrow: true, hideOnClick: false });
    },
  },
  watch: {
    artistData: function(val) {
      console.log("Changing artist data");
      $("#artistChart #bubbles").remove();
      this.renderChart(val, this);
    }
  }
};
</script>

<style>
#artist-chart #bubbles {
  size: 100%;
  display: block;
  margin: auto;
}

#artistChart {
  size: 100%;
  display: block;
  margin: auto;
}
</style>
