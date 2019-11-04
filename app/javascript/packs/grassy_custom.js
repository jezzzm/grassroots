$('#results-last').on('hidden.bs.collapse', function () {
  $('#results-more').text('More Results');
});
$('#results-last').on('shown.bs.collapse', function () {
  $('#results-more').text('Fewer Results');
});

$('#fixtures-last').on('hidden.bs.collapse', function () {
  $('#fixtures-more').text('More Fixtures');
});
$('#fixtures-last').on('shown.bs.collapse', function () {
  $('#fixtures-more').text('Fewer Fixtures');
});
console.log('custom js has run')
