<template>
  <div id="bubbleChart" class="chart"></div>
</template>

<script>
import cookie from "cookie";
import colors from "./colors.js";
import * as d3 from "d3";
import * as d3_chromatic from "d3-scale-chromatic";
import * as textwrap from "d3-textwrap";
import * as d3Selection from "d3-selection";
import "d3-extended";
import stringHash from "string-hash";
import tippy from "tippy.js";

export default {
	name: "bubbleChart",
	data() {
		return {
			data: ""
		};
	},
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
				d3
					.select(this.parentNode)
					.select("text")
					.style("visibility", "visible");
				var item = d3.select(this);
				if (item.attr("r") < 40) {
					item.attr("prevr", item.attr("r"));
					item.interrupt();
					item
						.transition()
						.ease(d3.easeLinear)
						.duration(100)
						.attr("r", item.attr("r") * 1 + 30);
				}
			};

			var clicker = function() {
				var genre = d3.select(this).datum().name;
				component.$emit(
					"genreClick",
					component.data.genres.filter(x => x.name === genre)[0]
				);
			};

			var mouseLeaveZoom = function() {
				var item = d3.select(this);
				item.interrupt();
				if (item.attr("prevr")) {
					item.attr("r", item.attr("prevr"));
				}
				if (item.attr("r") < 40) {
					d3
						.select(this.parentNode)
						.select("text")
						.style("visibility", "hidden");
				}
			};

			var bubble = d3
				.pack()
				.size([diameter, diameter])
				.padding(1.5);

			var svg = d3
				.select("#bubbleChart")
				.append("svg")
				.attr("width", diameter)
				.attr("height", diameter)
				.attr("class", "bubble")
				.attr("id", "bubbles")
				.style("overflow", "visible");

			function makeFlat(root) {
				var nodeThings = [];

				function recurse(name, node) {
					if (node.genres)
						node.genres.forEach(function(child) {
							recurse(node.name, child);
						});
					else
						nodeThings.push({
							name: node.name,
							size: node.size,
							artists_size: node.artists.length
						});
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
				.attr("title", function(d) {
					return (
						d.data.artists_size +
						(d.data.artists_size === 1 ? " artist" : " artists") +
						" | " +
						d.data.size +
						(d.data.size === 1 ? " listen" : " listens")
					);
				})
				.attr("transform", function(d) {
					return "translate(" + d.x + "," + d.y + ")";
				});

			node
				.append("circle")
				.attr("r", function(d) {
					return d.r;
				})
				.style("fill", function(d) {
					return getColor(d.data.name);
				})
				.datum(function(d) {
					return d.data;
				})
				.on("mouseenter", mouseEnterZoom)
				.on("mouseleave", mouseLeaveZoom)
				.on("click", clicker);

			function toTitleCase(str) {
				return str.replace(/\w\S*/g, function(txt) {
					return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
				});
			}

			node
				.append("text")
				.attr("dy", ".3em")
				.attr("pointer-events", "none")
				.style("text-anchor", "middle")
				.style("fill", "white")
				.text(function(d) {
					return toTitleCase(d.data.name);
				});

			d3.selectAll("circle").each(function(d, i) {
				var el = d3.select(this);
				if (el.attr("r") < 40) {
					d3.select(this.parentNode).attr("class", "node small-bubble");
				}
			});

			tippy("[title]", {
				followCursor: true,
				duration: "0",
				arrow: true
			});
		},

		hideSmallText: function() {
			$(".node circle").each(function() {
				if ($(this).attr("r") < 40) {
					$(this)
						.parent()
						.addClass("small-bubble");
				}
			});
		}
	},
	mounted: function() {
		axios({
			method: "get",
			url:
				"https://api.lucidi.fi/v1/usermetrics?token=" +
				cookie.parse(document.cookie).access_token
		}).then(
			function(response) {
				this.data = response.data;
				this.$emit("loaded");
			}.bind(this)
		);
	},
	watch: {
		data: function(val) {
			this.renderChart(val, this);
			this.hideSmallText();
		}
	}
};
</script>

<style>
#bubbles {
	size: 100%;
	display: block;
	margin: auto;
}

.small-bubble text {
	visibility: hidden;
}

text {
	font-family: "Roboto Condensed";
}

.node {
	outline: none;
}

#bubbleChart {
	size: 100%;
	display: block;
	margin: auto;
}
</style>
