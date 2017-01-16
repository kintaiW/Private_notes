$(document).ready(function() {
	
	$('code, pre').addClass('prettyprint1');
	prettyPrint();

	var pathname = window.location.pathname;
	$('input:#filter').focus();
	
	

	$.getJSON('/doc.json', {}, function(data) {
		var ul = $('#sliderbar > ul');
		var arr = [];

		$.each(data, function(i, n) {
			var cls = pathname == n.url ? " class=active " : "";

			arr.push([
					'<li>',
					'<a href=\"', n.url, '\"', cls , 
						'pinyin=\"', n.pinyin, '\" >', n.title, '</a>',
					'</li>'
				].join('')
			)
		});
		
		ul.append(arr.join('\n'));
		
		$('input#filter').quicksearch('#articals-list li', {
			delay: 200,
			tripeRows: ['odd', 'even'],
			bind: 'keyup keydown',
			testQuery: function(query, text, _row) {
				var target = $(_row).find('a').attr('pinyin');
				
				for (var i = 0; i < query.length; i += 1) {
					if (target.indexOf(query[i]) === -1) {
						return false;
					}
				}
				
				return true;
			}
		});
		
	});
	
	$("h3,h4,h5,h6").each(function(i,item){
		var tag = $(item).get(0).localName;
		$(item).attr("id","wow"+i);
		$("#category").append('<a class="new'+tag+'" href="#wow'+i+'">'+$(this).text()+'</a></br>');
		$(".newh3").css("margin-left",0);
		$(".newh4").css("margin-left",20);
		$(".newh5").css("margin-left",40);
		$(".newh6").css("margin-left",60);
	});

})