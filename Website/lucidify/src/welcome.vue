<template>
	<div>
		<div id="background"></div>
		<v-container id="welcome" text-md-center title-md-center>
			<v-layout row wrap pb-5 pt-5></v-layout>
			<v-layout row wrap pt-5>
				<v-flex>
					<v-card flat color="transparent">
						<v-card-text>
							<h1 class="display-4">{{ siteTitle }}</h1>
							<br>
							<h2>{{ subTitle }}</h2>
						</v-card-text>
					</v-card>
				</v-flex>
			</v-layout>
			<v-layout row wrap pb-5 pt-5></v-layout>
			<v-layout row wrap>
				<v-flex>
					<v-card flat color="transparent">
						<v-card-text>
							<h4>{{ siteMessage }}</h4>
						</v-card-text>
					</v-card>
				</v-flex>
			</v-layout>
			<v-layout row wrap>
				<v-flex md2 offset-md3>
					<v-card flat color="transparent">
						<v-card-text>
							<div>
								<h1 class="display-3" v-if="loaded">{{ users }}</h1>
								<h1 class="display-3" v-if="!loaded">
									<i class="fa fa-spinner fa-spin"></i>
								</h1>
								<h3>Users</h3>
							</div>
						</v-card-text>
					</v-card>
				</v-flex>
				<v-flex md2>
					<v-card flat color="transparent">
						<v-card-text>
							<div>
								<h1 class="display-3" v-if="loaded">{{ genres }}</h1>
								<h1 class="display-3" v-if="!loaded">
									<i class="fa fa-spinner fa-spin"></i>
								</h1>
								<h3>Genres</h3>
							</div>
						</v-card-text>
					</v-card>
				</v-flex>
				<v-flex md2>
					<v-card flat color="transparent">
						<v-card-text>
							<div>
								<h1 class="display-3" v-if="loaded">{{ listens }}</h1>
								<h1 class="display-3" v-if="!loaded">
									<i class="fa fa-spinner fa-spin"></i>
								</h1>
								<h3>Listens</h3>
							</div>
						</v-card-text>
					</v-card>
				</v-flex>
			</v-layout>
		</v-container>
	</div>
</template>

<script>
import AboutLucidify from "./aboutLucidify.vue";

export default {
	name: "welcome",
	data() {
		return {
			siteTitle: "Lucidify",
			siteMessage: "The Lucidify system is visualizing music habits for...",
			subTitle: "Visualizing music tastes for Spotify users",
			genres: "",
			listens: "",
			users: "",
			loaded: false
		};
	},

	components: {
		aboutLucidify: AboutLucidify
	},

	methods: {
		scrollToElement(id) {
			id = id.replace("link", "");
			$("html,body").animate(
				{
					scrollTop: $("#" + id).offset().top
				},
				"slow"
			);
		}
	},

	mounted: function() {
		axios.get("https://api.lucidi.fi/v1/stats").then(
			function(response) {
				this.genres = response.data.genres.toLocaleString();
				this.users = response.data.users.toLocaleString();
				this.listens = response.data.listens.toLocaleString();
				this.loaded = true;
			}.bind(this)
		);
	}
};
</script>

<style>
#welcome {
	padding-top: 45px;
}

#scrollBtn {
	position: absolute;
	left: 47.5%;
	bottom: 0;
	margin-bottom: 30px;

	background-color: green;
	color: white;
}

#scrollBtn:hover {
	background-color: darkgreen;
}

#welcomeMessage {
	padding-top: 5%;
}

#background {
	z-index: -1;
	background-image: url("https://static.pexels.com/photos/63703/pexels-photo-63703.jpeg");
	background-size: cover;
	position: fixed;
	height: 100%;
	width: 100%;
	transform: scale(1.02);

	-webkit-filter: blur(5px) brightness(30%);
	-webkit-opacity: 0.85;
}

#siteMessage {
	padding-top: 15%;
}
</style>
