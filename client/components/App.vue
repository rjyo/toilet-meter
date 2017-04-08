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
      return 'bg' + (this.bgId % 6 + 1)
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
  margin: 0;
  padding: 0;
  left: 0;
  top: 0;
  background-image: url(../assets/bg5.jpg);
  background-repeat: no-repeat;
  background-size: cover;
  transition: background 0.5s ease-in-out;

  &.bg1 { background-image: url(../assets/bg1.jpg); }
  &.bg2 { background-image: url(../assets/bg2.jpg); }
  &.bg3 { background-image: url(../assets/bg3.jpg); }
  &.bg4 { background-image: url(../assets/bg4.jpg); }
  &.bg5 { background-image: url(../assets/bg5.jpg); }
  &.bg6 { background-image: url(../assets/bg6.jpg); }
}
h1 {
  text-align: center;
}
</style>
