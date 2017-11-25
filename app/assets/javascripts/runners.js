// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// Vue.http.interceptors.push({
//   request: function (request) {
//     Vue.http.headers.common['X-CSRF-Token'] = $('[name="csrf-token"]').attr('content');
//     return request;
//   },
//   response: function (response) {
//     return response;
//   }
// });
// Vue.component('runner-row', {
//   template: '#runner-row',
//   props: {
//     runner: Object
//   }
// })

// var runners = new Vue({
//   el: "#runners",
//   data: {
//     loading: false,
//     runners: [],
//     order: 1,
//     currentPage: 1,
//     itemsPerPage: 25,
//     resultCount: 0,
//   },
//   mounted: function() {
//     this.loading = true;
//     var self;
//     self = this;
//     console.log("fetch data")
//     $.ajax ({
//       url: '/runners.json?page=1&per=25',
//       success: function(res) {
//         console.log("success")
//         self.loading = false;
//         self.runners = res;
//       }
//     })
//   },
//   computed: {
    
//   },
//   methods: {
    
//   }

// })

