<template>
    <div id="aboutLucidify">
        <p id="about">{{ aboutMessage }}</p>
    </div>
</template>

<script>
export default {
  name: "aboutLucidify",
  data() {
    return {
      aboutMessage:
        "Lucidify is brought to you by Team Lucidify, a senior design team from the Milwaukee School of Engineering."
    };
  }
};
</script>

<style>
#aboutLucidify {
  position: absolute;
  width: 100%;
  top: 100%;
  padding-top: 55px;
  height: 100%;
}

#about {
  padding-top: 10%;
}
</style>