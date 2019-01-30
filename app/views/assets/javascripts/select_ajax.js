// Select Categories
$(document).ready(function(){
	$.fn.modal.Constructor.prototype.enforceFocus = function() {};

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
					cluster: params.term,
					page: params.page || 1
				};
			},
			processResults: function(data) {
				var root = ""
				var root_name = Object.keys(data)[0]
				switch (root_name) {
					case "categories":
						root = "categories"
						break;
					case "users":
						root = "users"
						break;
					case "clusters":
						root = "clusters"
				}
				var result = $.map(data[root], function (item) { return { id: item.id, text: item.name || item.email }});
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
