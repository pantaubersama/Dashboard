// Select Categories
$(document).ready(function(){
	// Init Select2
	$('select.remote-select').select2({
		placeholder: "Search...",
		minimumInputLength: 3,
		ajax: {
			url: function (params) {
				return $(this).data('url')
			},
			dataType: 'json',
			delay: 250,
			cache: true,
			data: function (params) {
				return {
					q: params.term,
					page: params.page || 1
				};
			},
			processResults: function(data) {
				var result = $.map(data.categories, function (item) { return { id: item.id, text: item.name }});
				console.log(result)
				return { results: result };
			}
		}
	});

	// Reset Value
	$('button.reset').on('click', function(){
		a = $('select.stat').val('')
		b = $('input.q').val('')
		c = $('select.remote-select').val('').trigger('change')
	})

})
