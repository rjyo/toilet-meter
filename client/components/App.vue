<template>
  <div id="app" :class="bgClass">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  props: {
    bgId: {
      type: Number,
      default: 1
    }
  },
  computed: {
    bgClass () {
      return 'bg' + (this.bgId % 5 + 1)
    }
  },
  created () {
    setInterval(() => {
      this.bgId += 1
    }, 30000)
  }
}

</script>

<style>
body {
  font-size: 2rem;
  font-family: 'avenir next condensed', avenir, helvetica, 'helvetica neue', Ubuntu, 'segoe ui', arial, sans-serif;
}
#app {
  position: fixed;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  background-image: url(../assets/bg5.jpg);
  background-size: cover;
  background-repeat: no-repeat;
  margin: 0;
  padding: 0;
  transition: background 0.5s ease-in-out;
}
#app.bg1 {
  background-image: url(../assets/bg1.jpg);
}
#app.bg2 {
  background-image: url(../assets/bg2.jpg);
}
#app.bg3 {
  background-image: url(../assets/bg3.jpg);
}
#app.bg4 {
  background-image: url(../assets/bg4.jpg);
}
#app.bg5 {
  background-image: url(../assets/bg5.jpg);
}
#app.bg6 {
  background-image: url(../assets/bg6.jpg);
}
h1 {
  text-align: center;
}
.page {
  text-align: center;
  /* nesting for the need to test postcss */
  code {
    background-color: #f0f0f0;
    padding: 3px 5px;
    border-radius: 2px;
  }
}
</style>
