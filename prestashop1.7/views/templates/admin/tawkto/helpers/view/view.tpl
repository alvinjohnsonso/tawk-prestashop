<!--
/**
 * tawk.to
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to support@tawk.to so we can send you a copy immediately.
 * @author    tawk.to <support(at)tawk.to>
 * @copyright Copyright (c) 2014-2021 tawk.to
 * @license   http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 */
-->
{include file="toolbar.tpl" toolbar_btn=$toolbar_btn toolbar_scroll=$toolbar_scroll title=$title}
<link href="/modules/tawkto/css/admin.css" rel="stylesheet">

<div class="tawkheader">
  <div class="tawkmel">
    <img src="/modules/tawkto/views/img/tawky_big.png">
  </div>
  <div class="tawkheadtext">
    tawk.to Plugin Settings  </div>
</div>

<div class="tawksettingsbody">
    <div class="tawktabs">
        <button class="tawktablinks" onclick="opentab(event, 'account')" id="defaultOpen">Account Settings</button>
        <button class="tawktablinks" onclick="opentab(event, 'visibility')">Visibility Options</button>
    </div>
    <div id="account" class="tawktabcontent" >
        {if !$same_user}
        <div id="widget_already_set" class="alert alert-warning">Widget set by other user</div>
        {/if}
        <iframe id="tawk_iframe" src=""></iframe>
        <input type="hidden" class="hidden" name="page_id" value="{$page_id}">
        <input type="hidden" class="hidden" name="widget_id" value="{$widget_id}">
    </div>
    <div id="visibility" class="tawktabcontent">
        <div style="float: left; color: #3c763d; border-color: #d6e9c6; font-weight: bold;{if $page_id && $widget_id}display:none;{/if}" class="alert alert-warning visibility_warning">Please set the chat widget using the form above, to enable the chat visibility options.</div>
        <form id="module_form" action="" method="post">
            <div id="tawkvisibilitysettings">
                <h2>Visibility Options</h2>
                <p class='tawknotice'>
                Please Note: that you can use the visibility options below, or you can show the tawk.to widget
                <BR>
                on any page independent of these visibility options by simply using the <b>[tawkto]</b> shortcode in
                <BR>
                the post or page.
                </p>
                <table class="form-table">
                    <tr valign="top">
                        <th class="tawksetting" scope="row">Always show tawk.to widget on every page</th>
                        <td>
                            <label class="switch">
                                <input type="checkbox" class="slider round" id="always_display" name="always_display" value="1" {(is_null($display_opts)||$display_opts->always_display)?'checked':''} />
                                <div class="slider round"></div>
                            </label>
                        </td>
                    </tr>
                    <tr valign="top" class="twk_selected_display">
                        <th class="tawksetting" scope="row">Show on front page</th>
                        <td>
                            <label class="switch">
                                <input type="checkbox" class="slider round" id="show_onfrontpage" name="show_onfrontpage" value="1" {(!is_null($display_opts) && $display_opts->show_onfrontpage)?'checked':''} />
                                <div class="slider round"></div>
                            </label>
                        </td>
                    </tr>
                    <tr valign="top" class="twk_selected_display">
                        <th class="tawksetting" scope="row">Show on Category pages</th>
                        <td>
                            <label class="switch">
                                <input type="checkbox" class="slider round" id="show_oncategory" name="show_oncategory" value="1" {(!is_null($display_opts) && $display_opts->show_oncategory)?'checked':''} />
                                <div class="slider round"></div>
                            </label>
                        </td>
                    </tr>

                    <tr valign="top"  class="twk_selected_display">
                        <th class="tawksetting" scope="row">Show on product pages</th>
                        <td>
                            <label class="switch">
                                <input type="checkbox" class="slider round" id="show_onarticlepages" name="show_onproduct" value="1" {(!is_null($display_opts) && $display_opts->show_onproduct)?'checked':''} />
                                <div class="slider round"></div>
                            </label>
                        </td>
                    </tr>
                    <tr valign="top" class="always_display_fields">
                        <th class="tawksetting" scope="row">Exclude on specific url</th>
                        <td>
                            <label class="switch">
                                <input type="checkbox" class="slider round" id="exclude_url" name="exclude_url" value="1"
                                {(!is_null($display_opts) && !empty($display_opts->hide_oncustom))?'checked':''} />
                                <div class="slider round"></div>
                            </label>
                            <div id="exlucded_urls_container" style="display:none;">
                                {if (!is_null($display_opts) && !empty($display_opts->hide_oncustom)) }
                                {$whitelist = json_decode($display_opts->hide_oncustom)}
                                <textarea name="hide_oncustom" id="hide_oncustom" cols="30"
                                    rows="10">{foreach from=$whitelist item=page}{$page}{"\r\n"}{/foreach}</textarea>
                                {else}
                                <textarea class="hide_specific" name="hide_oncustom" id="hide_oncustom" cols="30" rows="10"></textarea>
                                {/if}
                                <p>Enter the url where you <b>DO NOT</b> want the widget to display.</p>
                            </div>
                        </td>
                    </tr>
                    <tr valign="top"  class="twk_selected_display">
                        <th class="tawksetting" scope="row">Include on specific url</th>
                        <td>
                            <label class="switch">
                                <input type="checkbox" class="slider round" id="include_url" name="include_url" value="1"
                                {(!is_null($display_opts) && !empty($display_opts->show_oncustom))?'checked':''}
                                />
                                <div class="slider round"></div>
                            </label>
                            <div id="included_urls_container" style="display:none;">
                                {if (!is_null($display_opts) && !empty($display_opts->show_oncustom)) }
                                {$whitelist = json_decode($display_opts->show_oncustom)}
                                <textarea name="show_oncustom" id="show_oncustom" cols="30"
                                    rows="10">{foreach from=$whitelist item=page}{$page}{"\r\n"}{/foreach}</textarea>
                                {else}
                                <textarea class="show_specific" name="show_oncustom" id="show_oncustom" cols="30" rows="10"></textarea>
                                {/if}
                                <p>Enter the url where you <b>WANT</b> the widget to display.</p>
                            </div>
                        </td>
                    </tr>
                </table>
                <div>
                    <div id="optionsSuccessMessage" style="width: 50%; background-color: #dff0d8; color: #3c763d; border-color: #d6e9c6; font-weight: bold;margin-left: 20px;display: none;" class="alert alert-success">Successfully set widget options to your site</div>
                    <button name="submit" id="submit" class="button button-primary save_button">Save Changes</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
var domain = '{$domain}';
var currentHost = window.location.protocol + "//" + domain,
    url = "{$iframe_url}&parentDomain=" + currentHost,
    baseUrl = '{$base_url}',
    current_id_tab = '{$tab_id}',
    controller = '{$controller}';

{literal}
jQuery('#tawk_iframe').attr('src', url);

var iframe = jQuery('#tawk_widget_customization')[0];

window.addEventListener('message', function(e) {
    if(e.origin === baseUrl) {

        if(e.data.action === 'setWidget') {
            setWidget(e);
        }

        if(e.data.action === 'removeWidget') {
            removeWidget(e);
        }
    }
});

function setWidget(e) {

    $.ajax({
        type     : 'POST',
        url      : controller,
        dataType : 'json',
        data     : {
            controller : 'AdminTawkto',
            action     : 'setWidget',
            ajax       : true,
            id_tab     : current_id_tab,
            pageId     : e.data.pageId,
            widgetId   : e.data.widgetId,
            domain     : domain
        },
        success : function(r) {
            if(r.success) {
                e.source.postMessage({action: 'setDone'} , baseUrl);

                $('input[name="page_id"]').val(e.data.pageId);
                $('input[name="widget_id"]').val(e.data.widgetId);
                $('#module_form, .visibility_warning').toggle();
            } else {
                e.source.postMessage({action: 'setFail'} , baseUrl);
            }
        }
    });
}

function removeWidget(e) {
    $.ajax({
        type     : 'POST',
        url      : controller,
        dataType : 'json',
        data     : {
            controller : 'AdminTawkto',
            action     : 'removeWidget',
            ajax       : true,
            id_tab     : current_id_tab,
            domain     : domain
        },
        success : function(r) {
            if(r.success) {
                e.source.postMessage({action: 'removeDone'} , baseUrl);

                $('input[name="page_id"]').val(e.data.pageId);
                $('input[name="widget_id"]').val(e.data.widgetId);
                $('#module_form, .visibility_warning').toggle();
            } else {
                e.source.postMessage({action: 'removeFail'} , baseUrl);
            }
        }
    });
}

jQuery(document).ready(function() {
{/literal}

{if !$page_id or !$widget_id}
    $('#module_form').hide();
{/if}

{literal}
// process the form
$('.save_button').on('click', function(event) {
    $.ajax({
        type     : 'POST',
        url      : controller,
        dataType : 'json',
        dataType : 'json',
        data     : {
            controller : 'AdminTawkto',
            action     : 'setVisibility',
            ajax       : true,
            id_tab     : current_id_tab,
            pageId     : $('input[name="page_id"]').val(),
            widgetId   : $('input[name="widget_id"]').val(),
            domain     : domain,
            options    : $('#module_form').serialize()
        },
        success : function(r) {
            if(r.success) {
                $('#optionsSuccessMessage').toggle().delay(3000).fadeOut();
            } else {
            }
        }
    });

    // stop the form from submitting the normal way and refreshing the page
    event.preventDefault();
});

if(jQuery("#always_display").prop("checked")){
    jQuery('.show_specific').prop('disabled', true);
} else {
    jQuery('.hide_specific').prop('disabled', true);
}

jQuery("#always_display").change(function() {
    if(this.checked){
        jQuery('.hide_specific').prop('disabled', false);
        jQuery('.show_specific').prop('disabled', true);
    }else{
        jQuery('.hide_specific').prop('disabled', true);
        jQuery('.show_specific').prop('disabled', false);
    }
});

jQuery(function() {
    document.getElementById("defaultOpen").click();

    if(jQuery("#always_display").prop("checked")){
        jQuery('.twk_selected_display').hide();
        jQuery('#show_onfrontpage').prop('disabled', true);
        jQuery('#show_oncategory').prop('disabled', true);
        jQuery('#show_ontagpage').prop('disabled', true);
        jQuery('#show_onarticlepages').prop('disabled', true);
        jQuery('#include_url').prop('disabled', true);
    }else{
        jQuery('.twk_selected_display').show();
        jQuery('.always_display_fields').hide();
    }

    jQuery("#always_display").change(function() {
        if(this.checked){
            jQuery('.twk_selected_display').fadeOut();
            jQuery('.always_display_fields').fadeIn();
            jQuery('#show_onfrontpage').prop('disabled', true);
            jQuery('#show_oncategory').prop('disabled', true);
            jQuery('#show_ontagpage').prop('disabled', true);
            jQuery('#show_onarticlepages').prop('disabled', true);
            jQuery('#include_url').prop('disabled', true);
        }else{
            jQuery('.twk_selected_display').fadeIn();
            jQuery('.always_display_fields').fadeOut();
            jQuery('#show_onfrontpage').prop('disabled', false);
            jQuery('#show_oncategory').prop('disabled', false);
            jQuery('#show_ontagpage').prop('disabled', false);
            jQuery('#show_onarticlepages').prop('disabled', false);
            jQuery('#include_url').prop('disabled', false);
        }
    });

    if(jQuery("#include_url").prop("checked")){
        jQuery("#included_urls_container").show();
    }

    jQuery("#include_url").change(function() {
        if(this.checked){
            jQuery("#included_urls_container").fadeIn();
        }else{
            jQuery("#included_urls_container").fadeOut();
        }
    });

    if(jQuery("#exclude_url").prop("checked")){
        jQuery("#exlucded_urls_container").fadeIn();
    }

    jQuery("#exclude_url").change(function() {
        if(this.checked){
            jQuery("#exlucded_urls_container").fadeIn();
        }else{
            jQuery("#exlucded_urls_container").fadeOut();
        }
    });
});

});
function opentab(evt, tabName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    tabcontent = document.getElementsByClassName("tawktabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    tablinks = document.getElementsByClassName("tawktablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}
{/literal}
</script>
