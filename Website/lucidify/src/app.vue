<template>
    <div id="app">

        <v-app class="transparentBackground" dark>
        <navbar></navbar>
        <!--component v-bind:is='currentView'></component-->

        <welcome v-if="!loggedOn()"></welcome>
        <graphView v-if="loggedOn()"></graphView>
        </v-app>
    </div>
</template>

<script>
    import Navbar from "./navbar.vue";
    import Welcome from "./welcome.vue";
    import GraphView from "./graphView.vue";
    import cookie from 'cookie';

    export default {
        name: "app",
        data: function () {
            return {
                currentView:
                    "welcome" /* will swap this out dynamically for desired component as needed */
            };
        },
        components: {
            navbar: Navbar,
            welcome: Welcome,
            graphView: GraphView
        },

        methods: {
            swapComponent(id) {
                this.currentView = id;
            },

            loggedOn() {
                if (cookie.parse(document.cookie).access_token) {
                    return true;
                }
                return false;
            }
        }
    };
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Roboto|Roboto+Condensed');
* {
    font-family: 'Roboto'
}

.transparentBackground {
  background: transparent !important;
  background-color: transparent !important;
  color: transparent !important;
}



</style>
