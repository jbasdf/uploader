jQuery(document).ready(function() {
	jQuery(".tip-field").focus(function() {
		jQuery(".active").removeClass("active");
		var tip_key = jQuery('#' + this.id).siblings('#tip-key');
		var control_id = this.id;
		var help_id = this.id;
		if (tip_key.length > 0){
			control_id = tip_key.html();
			help_id = jQuery('#' + this.id).siblings('#tip-id').html();
		}		
		var tip_text = jQuery('#' + help_id + "-help").html();
		var tip_title = jQuery('#' + help_id + "-help-title").html();
		var tip_position = jQuery('#' + help_id + "-help-position").html();
		if (!tip_position) { tip_position = 'right'; }
		show_tip(control_id, tip_title, tip_text, tip_position);
		jQuery("#" + help_id + "-container").addClass("active");
	});

	jQuery(".tip-field").blur(function() {
		jQuery('#' + this.id + '-tip').hide(1);
	});
});

function show_tip(object_id,title,tip_text,position) {
	if(title == false || title == null)title="&nbsp;";
	var tip_id = object_id + '-tip';
	jQuery('#' + tip_id).remove();
	var elem = jQuery('#' + object_id);
	if(elem[0].type == 'checkbox') {
		elem = elem.siblings("label");
	}
	var elemPos = elem.offset();
	var elemWidth = elem.outerWidth();
	var elemHeight = elem.outerHeight();
	// default is bottom
	var position_class = 'bottom-tip';
	var tip_header = '';
	var posX = elemPos.left;
	var posY = elemPos.top + elemHeight;
	
	if (position == 'right'){
		posX = elemPos.left + elemWidth;
		posY = elemPos.top;
		position_class = 'right-tip';
	} else if (position == 'left') {
		position_class = 'left-tip';
	} else if (position == 'top') {
		position_class = 'top-tip';
	}

	var tip_header = '<div id="tip-header"></div>';
	var tip_content = '<div id="tip-title">' + title + '</div><div id="tip-main"><div class="tip-content">' + tip_text + '</div></div>';
	var combined = tip_header + tip_content;
	if (position == 'top') { combined = tip_content + tip_header; }
	jQuery('#' + tip_id).remove(); // remove the old one
	jQuery("body").append('<div id="' + tip_id + '" class="tip ' + position_class + '">' + combined + '</div>');
	var tool_tip = jQuery('#' + tip_id);
	
	if (position == 'left') {
		posX = elemPos.left - (tool_tip.outerWidth() + parseInt(tool_tip.css('margin-right')));
		posY = elemPos.top;
	} else if (position == 'top') {
		posX = elemPos.left;
		posY = elemPos.top - (tool_tip.outerHeight() + parseInt(tool_tip.css('margin-bottom')));
	}
			
	tool_tip.css({left: posX + "px", top: posY + "px"});
	tool_tip.show();
}