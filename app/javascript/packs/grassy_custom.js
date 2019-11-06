$(document).ready(function() {
  function updateTeams(c, ag, d, nodeID) {
    const selectedClub = $(c).val();
    const selectedAgeGroup = $(ag).val();
    const selectedDivision = $(d).val();

    //update data visible in table
    rows = $(nodeID).children()
    for (let i = 0; i < rows.length; i++ ) {
      const club = rows[i].querySelector('.club').innerText;
      const ageGroup = rows[i].querySelector('.age-group').innerText;
      const division = rows[i].querySelector('.division').innerText;

      if (selectedClub.length > 0) {
        if (club == selectedClub) {
          rows[i].style.display = "";
        } else {
          rows[i].style.display = "none";
        }
        $(ag).prop('disabled', false)
        if (selectedAgeGroup.length > 0) {
          if (club == selectedClub && ageGroup == selectedAgeGroup) {
            rows[i].style.display = "";
          } else {
            rows[i].style.display = "none";
          }
          $(d).prop('disabled', false)
          if (selectedDivision.length > 0) {
            if (club == selectedClub && ageGroup == selectedAgeGroup && division == selectedDivision) {
              rows[i].style.display = "";
            } else {
              rows[i].style.display = "none";
            }
          }
        } else {
          $(d).prop('disabled', true)
        }
      } else {
        $(ag).prop('disabled', true)
        rows[i].style.display = "none";
      }

    }

    //update dropdowns
    let visibleRows = $(nodeID).children('tr:visible'); //should only be options for one team
    let visibleAgeGroups = [];
    let visibleDivisions = [];
    for (let i = 0; i < visibleRows.length; i++) {
      const ageGroup = visibleRows[i].querySelector('.age-group').innerText;
      const division = parseInt(visibleRows[i].querySelector('.division').innerText);
      visibleAgeGroups.includes(ageGroup) ? null : visibleAgeGroups.push(ageGroup)
      visibleDivisions.includes(division) ? null : visibleDivisions.push(division)
    }

    visibleAgeGroups.sort()
    visibleDivisions.sort()

    $(ag).empty()
    // $(ag).append(`<option value=""></option>`)
    for (let i = 0; i < visibleAgeGroups.length; i++) {
      $(ag).append(`<option value="${visibleAgeGroups[i]}">${visibleAgeGroups[i]}</option>`)
    }

    $(d).empty()
    // $(d).append(`<option value=""></option>`)
    for (let i = 0; i < visibleDivisions.length; i++) {
      $(d).append(`<option value="${visibleDivisions[i]}">${visibleDivisions[i]}</option>`)
    }
  };

  function resetFilters() {
    //no rows display

    //all clubs, age groups, divisions repopulated

    //age group and division greyed out
  }

  console.log('before');

  $('#results-last').on('hide.bs.collapse', function () {
    $('#results-more').text('More Results');
  });
  $('#results-last').on('show.bs.collapse', function () {
    $('#results-more').text('Fewer Results');
  });

  $('#fixtures-last').on('hide.bs.collapse', function () {
    $('#fixtures-more').text('More Fixtures');
  });
  $('#fixtures-last').on('show.bs.collapse', function () {
    $('#fixtures-more').text('Fewer Fixtures');
  });

  $('#club-dd').on('change', () => updateTeams('#club-dd', '#age-group-dd', '#division-dd', '#teams'))
  $('#age-group-dd').on('change', () => updateTeams('#club-dd', '#age-group-dd', '#division-dd', '#teams'))
  $('#division-dd').on('change', () => updateTeams('#club-dd', '#age-group-dd', '#division-dd', '#teams'))


  console.log('after');



});
