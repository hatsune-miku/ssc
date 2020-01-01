
console.log('program started.');


import Vue from 'vue'
import App from '../app.vue'

// finally support for axios.
require('promise.prototype.finally').shim();

import ElementUI from 'element-ui'
import '../../assets/stylesheets/element-custom.sass'


Vue.use(ElementUI);

import 'default-passive-events'

document.addEventListener('DOMContentLoaded', () => {
    new Vue({
        el: '#app',
        render: h => h(App)
    });
});
