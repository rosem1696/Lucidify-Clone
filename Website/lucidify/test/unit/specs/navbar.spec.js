import Vue from 'vue'
import navbar from '@/navbar'

describe('navbar.vue', () => {
  it('should render correct contents', () => {
    const Constructor = Vue.extend(navbar)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.navbar-brand').textContent)
      .to.equal('Lucidify')
  })
})
