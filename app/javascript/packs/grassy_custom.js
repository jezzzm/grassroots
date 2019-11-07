$(document).ready(function() {
  function updateTeams(nodeID) {
    const c = "#club-dd"
    const ag = "#age-group-dd"
    const d = "#division-dd"
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
          visibleDivisions.includes(parseInt(division)) ? null : visibleDivisions.push(parseInt(division))
          $(d).prop('disabled', true)
        }
      } else {
        $(ag).prop('disabled', true)
        rows[i].style.display = "none";
        visibleAgeGroups.includes(ageGroup) ? null : visibleAgeGroups.push(ageGroup)
        visibleDivisions.includes(parseInt(division)) ? null : visibleDivisions.push(parseInt(division))
      }

    }



    //update dropdowns
  //   visibleAgeGroups.sort()
  //   visibleDivisions.sort()
  //
  //   $(ag).empty()
  //   // $(ag).append(`<option value=""></option>`)
  //   for (let i = 0; i < visibleAgeGroups.length; i++) {
  //     $(ag).append(`<option value="${visibleAgeGroups[i]}">${visibleAgeGroups[i]}</option>`)
  //     $(`${ag}:last-child`).val() == selectedAgeGroup ? $(`${ag}:last-child`).attr('selected', 'selected'): null;
  //   }
  //
  //   $(d).empty()
  //   // $(d).append(`<option value=""></option>`)
  //   for (let i = 0; i < visibleDivisions.length; i++) {
  //     $(d).append(`<option value="${visibleDivisions[i]}">${visibleDivisions[i]}</option>`)
  //     $(`${d}:last-child`).val() == selectedDivision ? $(`${d}:last-child`).attr('selected', 'selected'): null;
  //   }
  };

  function filterIt() {

  }

  function searchGround() {
    const value = $(this).val().toLowerCase();
    $("#ground-list tbody tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  }

  function resetFilters() {
    //toggle and reset
    $('#club-dd option').first().attr('selected', 'selected')
    $('#age-group-dd option').first().attr('selected', 'selected')
    $('#division-dd option').first().attr('selected', 'selected')
    updateTeams('#teams')
    $('#club-dd option').first().removeAttr('selected')
    $('#age-group-dd option').first().removeAttr('selected')
    $('#division-dd option').first().removeAttr('selected')
  }


  $('#club-dd').on('change', () => updateTeams('#teams'))
  $('#age-group-dd').on('change', () => updateTeams('#teams'))
  $('#division-dd').on('change', () => updateTeams('#teams'))
  $('#reset-filters').on('click', resetFilters)

  $('#ground-search').on('keyup blur', searchGround)

});
