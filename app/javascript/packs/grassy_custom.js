$(document).ready(function() {
  function teamFilter(teams, filters) {
    var _this = this;

    this.init = function() {
      this.teams = teams;
      this.filters = filters;
      this.bindEvents();
    };

    this.bindEvents = function() {
      this.filters.click(this.filterTeams);
      $('#reset').click(this.resetFilters);
    };

    this.filterTeams = function() {
      //hide all
      _this.teams.hide();
      var filteredTeams =  _this.doFilter(_this.teams, $('.filter-attribs'));
      //show filtered
      filteredTeams.show();
    };

    this.resetFilters = function() {
      _this.filters.attr('checked', false);
      _this.teams.show();
    };

    this.doFilter = function(teams, filterAttribs) {
      // for each attribute check the corresponding attribute filters selected
      var filteredTeams = teams;
      filterAttribs.each(function(){
        var selectedFilters = $(this).find('input:checked');
        // if any filter selected
        if (selectedFilters.length > 0) {
          filteredTeams = filteredTeams.filter(_this.getFilterString(selectedFilters));
        }
      });
      return filteredTeams;
    };

    this.getFilterString = function(selectedFilters) {
      var selectedFilterValues = [];
      selectedFilters.each(function() {
        var currentFilter = $(this);
        selectedFilterValues.push(`[data-${currentFilter.attr('name')}='${currentFilter.val()}']`);

      });
      return selectedFilterValues.join(',');
    };
  }

  function searchGround() {
    const value = $(this).val().toLowerCase();
    $("#ground-list tbody tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  }

  function searchClub() {
    const value = $(this).val().toLowerCase();
    $("#clubs li.club").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  }

  $('#clubs-heading').on('click', function() {
    $('#clubs-arrow').toggleClass('fa-chevron-down')
    $('#clubs-arrow').toggleClass('fa-chevron-up')
  });
  $('#ages-heading').on('click', function() {
    $('#ages-arrow').toggleClass('fa-chevron-down')
    $('#ages-arrow').toggleClass('fa-chevron-up')
  });
  $('#divs-heading').on('click', function() {
    $('#divs-arrow').toggleClass('fa-chevron-down')
    $('#divs-arrow').toggleClass('fa-chevron-up')
  });



  $('#club-search').on('keyup blur', searchClub)
  $('#ground-search').on('keyup blur', searchGround)

  var $teams = $('.grid-teams');
  var $filters = $("#filters input[type='checkbox']");
  var team_filter = new teamFilter($teams, $filters);
  team_filter.init();

});
