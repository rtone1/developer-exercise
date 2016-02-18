// NOTE. I'm not sure if this paginated view is the best way to create pagination, so
// I would appriciate any feed back you can give me.
// I left all the scipts in this file in order to make it easier to navigate, but
// separating the models, collections, and views is better way to do things.

var app =  app || {};

  // BAKCBONE MODEL
  app.QuotesModel = Backbone.Model.extend({});

  // BACKBONE COLLECTIONS
  app.QuotesTemplate = $('#quotesTemplate').html();

  // BACKBONE COLLECTIONS
  app.QuotesList = Backbone.Collection.extend({
      model: app.QuotesModel,
      url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json',
  });

  // BACKBONE COLLECTIONS FOR GAMES
  app.GameQuotesList = Backbone.Collection.extend({
      model: app.QuotesModel,
      url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json',
      parse : function(data){
          var games = [];
          for (var model in data){
            var response = data[model];
            if (response.theme == 'games'){
              games.push(response);
            }
          }
          return games;
       }
  });

  // BACKBONE COLLECTIONS FOR MOVIES
  app.MovieQuotesList = Backbone.Collection.extend({
      model: app.QuotesModel,
      url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json',
      parse : function(data){
          var movies = [];
          for (var model in data){
            var response = data[model];
            if (response.theme == 'movies'){
              movies.push(response);
            }
          }
          return movies;
       }
  });

  // BACKBONE VIEW WITH PAGINATION
  app.QuotesView = Backbone.View.extend({
      el: "#quotesList",
      template: _.template(app.QuotesTemplate),
      page: 0,
      perPage: 15,
      totalPages: 0,
      loadMore: null,
      initialize: function() {
          this.loadMore = new app.LoadMoreQuotesView();
      },
      events: {
          "click .load-more-quotes": "renderNextQuoteGroup"
      },
      render: function (eventName) {
          this.totalPages = Math.ceil(_.size(this.model.models) / this.perPage);
          return this.renderQuoteGroup(0, this.perPage - 1);
      },
      renderQuoteGroup : function(start, end) {
          var subset = _.filter(this.model.models, function(num, index){
              return (index >= start) && (index <= end);
          });

          _.each(subset, function (quote) {
              var quoteTemplate = this.template(quote.toJSON());
              $(this.el).append(quoteTemplate);
          }, this);

          this.renderLoadMoreButton();

          return this;
      },
      renderNextQuoteGroup: function () {
          if(this.page < this.totalPages) {
              this.page++;
              var start = this.page * this.perPage;
              var end = start + (this.perPage - 1);
              this.renderQuoteGroup(start, end);
          }
      },
      renderLoadMoreButton: function() {
          // SHOW OR HIDE LOADMORE BUTTON
          if(this.page >= (this.totalPages - 1)) {
              this.loadMore.$el.hide();
          }

          else {
              this.$el.append( this.loadMore.$el.detach().show() );
          }
      }
  });

  // BACKBONE VIEW TO TIGGER LOAD OBJECTS
  app.LoadMoreQuotesView = Backbone.View.extend({
      el: $("#load-more-quotes")
  });


// RUN SCRIPTS WHEN DOCUMENT IS READY
$(document).ready(function(){

    // INITIALIZE VIEW WHITH ALL QUOTES
    function init(){
          app.quotes = new app.QuotesList();
          app.quotesView = new app.QuotesView({
              model: app.quotes
          });
          app.quotes.fetch();
          app.quotes.bind('sync', function () {
            app.quotesView.render();
          });
    };
    init();

    // RERENDER VIEW WHITH ALL QUOTES
    $('.all').on('click', function(){
          $('ul').empty();
          init();
    });

    // INITIALIZE VIEW WHITH GAMES QUOTES
    $('.games').on('click', function(){
          $('ul').empty();
          app.gameQuotesList = new app.GameQuotesList();
          app.quotesView = new app.QuotesView({
              model: app.gameQuotesList
          });
          app.gameQuotesList.fetch();
          app.gameQuotesList.bind('sync', function () {
            app.quotesView.render();
          });
    });

    // INITIALIZE VIEW WHITH MOVIES QUOTES
    $('.movies').on('click', function(){
          $('ul').empty();
          app.moviesQuotesList = new app.MovieQuotesList();
          app.quotesView = new app.QuotesView({
              model: app.moviesQuotesList
          });
          app.moviesQuotesList.fetch();
          app.moviesQuotesList.bind('sync', function () {
            app.quotesView.render();
          });
    });

}); // END OF DOCUMENT READY FUNCTION
