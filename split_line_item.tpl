{include file="header.tpl" page_name='View Order' extra_javascript='<script language="JavaScript" src="includes/view_order.js?v=5"></script>'}
{literal}
<style>
.rowsm a {
	color: black;
	border: solid 1px black;
	font: bold 12px arial, verdana, sans-serif;
	padding: 4px;
	background-color: #c6c6c6;
	display: inline-block;
	margin: 5px 0;
}

.sticky .rowsm {
	background-color: #fff;
	width: 100%;
	top: 0;
	left: 0;
	position: fixed;
}

.MsgBox {
	border: 1px solid;
	margin: 10px auto;
	padding:15px 10px 15px 50px;
	background-repeat: no-repeat;
	background-position: 10px center;
	width:75%;
}

.info {
	color: #00529B;
	background-color: #BDE5F8;
}

#addItem {
	display: none;
	text-align: left;
}

.addItemButton {
	float: right;
	padding: 5px;
	border: 1px solid;
	margin-top: 3px;
	cursor: pointer;
}

.messageDetail {
	text-align: left;
}
</style>
{/literal}

<form  name = 'split_line_item' class = 'radio_form_class' method = 'post' action = 'split_line_item.php?id={$id}&{$search_params}' onsubmit="return check_radio_and_validate_quantity()">
<div class="rowsm" align="center">
{if isset($search_page_hlink) }
	<a href="{$search_page_hlink}" style="background-color:#FFCCFF">Refine Search</a>
{/if}
{if isset($search_results_hlink) }
	<a href="{$search_results_hlink}" style="background-color:#99FFFF"><< Search Results</a>
{/if}
	<a href="print_order.php?id={$id}" target="_blank" style="background-color:#33FF00">Print PO</a>
{if ($tpl_shipcountry == "CA")}
	<a href="../canada/view_invoice.php?id={$id}{if ($tpl_vendor_fk != 0)}&vendor_id={$tpl_vendor_fk}{/if}" target="_blank">View Invoice</a>
{/if}
	<a href="{$next_order_hlink}" style="background-color:#83A984">&lt;&lt; Earlier PO</a>
	<a href="{$prev_order_hlink}" style="background-color:#83A984">Later PO &gt;&gt;</a>
{if (($tpl_show_ops) || ($tpl_show_all))}
	<a href="edit_order.php?id={$id}&{$search_params}" style="background-color:#FFFF00">Edit PO</a>
{if $place_order_flag}
	<a href="place_vendor_orders.php?id={$id}&{$search_params}" style="background-color:#FF0000;color#FFFFFF">Place Order</a>
{/if}
{if $resend_order_flag}
	<a href="resend_vendor_orders.php?id={$id}&{$search_params}" style="background-color:#FFCCCC" >Resend</a>
{/if}
{if $delete_order_flag}
	<a href="view_order.php?delete_order=true&id={$id}&{$search_params}" onclick="return confirm("Do you really want to delete this order?");">Delete</a>
{/if}
{if $send_sn_flag}
	<a href="shipping_notice.php?id={$id}&{$search_params}">Send Shipping Notice</a>
{/if}
{if $resend_sn_flag}
	<a href="id=shipping_notice.php?repeat=true&{$id}&{$search_params}">Resend Shipping Notice</a>
{/if}
{if $update_shipping_info_flag}
	<a href="update_shipping_info.php?id={$id}&{$search_params}" style="font-weight:bold;color:#4D148C;background-color:#E5E5E7">Update Shipping Info</a>
{/if}
{if $tpl_split_line_item}
	<a href="update_shipping_info.php?id={$id}&{$search_params}" style="font-weight:bold;color:#4D148C;background-color:#99FFFF">Split Line Item</a>
{/if}
{if $valid_order_flag}
	<a href="upload_shipping_label.php?id={$id}" style="font-weight:bold;color:#4C1600;background-color:#FF9900">Upload Shipping Label</a>
{/if}
{if $create_rtv_flag}
	<a href="process_rtv.php?id={$id}&{$search_params}" style="background-color:#CCFFFF">New RTV</a>
{/if}
	<a href="customer_mail.php?id={$id}&{$search_params}" style="background-color:#0066FF;color:#FFFFFF">Email</a>
{/if}
{if isset($message) }
	<div id="message">{$message}</div>
{/if}
</div>

<div id="col3" class="ui-helper-clearfix">
{if $tpl_order_flag > 0 and $tpl_order_flag < 99}
	<div class="row">
		<div class="MsgBox info">Order Currently Flagged: <b>{$tpl_order_flag_name}</b> {if $tpl_order_flag_comment != ""} - {$tpl_order_flag_comment}{/if}</div>
	</div>
{/if}
<div class="row">
{if ($tpl_show_all == TRUE) || ($tpl_show_ops == TRUE) || ($tpl_show_ven == TRUE)}
		<fieldset id="left">
			<legend>Order Information</legend>
			<table class="table1">
				<tr id="row3">
					<td width="35%">PO Number</td>
					<td width="35%">Order Status</td>
{if $tpl_show_ven == TRUE}
					<td width="30%">&nbsp;</td>
{else}
					<td width="30%">Call Center PO</td>
{/if}
				</tr>
				<tr id="row4">
					<td>{$tpl_po_num}</td>
					<td>{$tpl_order_status}</td>
{if $tpl_show_ven == TRUE}
					<td/>
{else}
					<td>{$tpl_call_centre}</td>
{/if}
				</tr>
				<tr id="row3">
					<td>Order Date</td>
					<td>Placed Date</td>
					<td><span style="float: left;">Promo Discount</span>{if ($tpl_promocode)}<div id="promoInfo" class="ui-state-default ui-corner-all" style="float: left;margin-left: 7px;position: relative;"><span class="ui-icon ui-icon-help" style="float: left;"></span><div id="promoInfoBox" class="ui-state-default ui-corner-all" style="position: absolute;padding: 3px;color: #444;width: 300px;">{$promoCode}: {$promoDescription}</div></div>{/if}</td>
				</tr>
				<tr id="row4">
					<td>{$tpl_ord_date}</td>
					<td>{$tpl_placed_date}</td>
					<td>${$tpl_promodiscount}</td>
				</tr>
{if ($tpl_redeem_discount != 0)}
				<tr id="row4">
					<td>Redeemed Points Discount</td>
					<td>{$tpl_redeem_discount|string_format:"%.2f"}</td>
					<td>&nbsp;</td>
				</tr>
{/if}
{if (isset($tpl_gcert_amount))}
				<tr id="row4">
					<td>Gift Card Discount</td>
					<td>{$tpl_gcert_amount|string_format:"%.2f"}</td>
					<td>&nbsp;</td>
				</tr>
{/if}
{if $tpl_show_ven == TRUE}
				<tr/>
{else}
				<tr id="row3">
					<td>Shipping Amount</td>
					<td>Tax Amount ({$tpl_tax_rate}%)</td>
					<td>Grand Total</td>
				</tr>
				<tr id="row4">
					<td>{$tpl_shpng}{if ($tpl_shipping_cost != 0.0)} (Est. Cost: {$tpl_shipping_cost}){/if}</td>
					<td>{$tpl_tax}</td>
{if ($tpl_grand_total != $tpl_original_grand_total)}
					<td class="cellhighlight">{$tpl_grand_total} (Originally {$tpl_original_grand_total}){if ($tpl_pay_method == 'Amazon Canada')} CAD{/if}</td>
{else}
					<td>{$tpl_grand_total}{if ($tpl_pay_method == 'Amazon Canada')} CAD{/if}</td>
{/if}
				</tr>
{/if}
				<tr id="row3">
					<td>Customer IP</td>
					<td>Buy Safe{if $tpl_buySafe == 'true' && $tpl_order_status != 'CAN'} <span id="cancelBuySafeBond" style="color: red;cursor: pointer;">[Cancel Bond]</span>{/if}</td>
					<td>{if isset($tpl_order_source)}Order Source{/if}</td>
				</tr>
				<tr id="row4">
					<td>{$tpl_clientIP}</td>
					<td>{$tpl_buySafeValue}</td>
					<td>{if isset($tpl_order_source)}{if ($tpl_order_source == 1)}Share-A-Sale{/if}{/if}</td>
				</tr>
{if isset($tpl_linkShareId)}
				<tr id="row3">
					<td colspan="3">LinkShare Order</td>
				</tr>
{/if}
{if $tpl_gift_message != ""}
				<tr id="row3"><td colspan="3">Gift Message</td></tr>
				<tr id="row4">
					<td colspan="3">{$tpl_gift_message|nl2br}</td>
				</tr>
{/if}
				<tr id="row3">
					<td colspan="3">Order Notes</td>
				</tr>
				<tr id="row4">
{if $tpl_order_notes != ""}
					<td colspan="3" class="cellhighlight">{$tpl_order_notes}</td>
{else}
					<td colspan="3">&nbsp;</td>
{/if}
				</tr>
			</table>
		</fieldset>
{/if}
		<br />
{if ($tpl_show_all == TRUE) || ($tpl_show_ops == TRUE) || ($tpl_show_ven == TRUE)}
		<fieldset id="right">
			<legend>Customer Information</legend>
			<table class="table1">
				<tr id="row3">
					<td width="50%">Customer Name</td>
					<td width="50%" class="row4">{$tpl_name}</td>
				</tr>
{/if}				
{if $tpl_show_ven == TRUE}
				<tr/>
{elseif $tpl_pay_method != "PayPal" AND $tpl_pay_method != "Amazon Store" AND $tpl_pay_method != "Amazon Canada" AND $tpl_pay_method != "eBay" AND $tpl_pay_method != "Sears"  AND $tpl_pay_method != "Rakuten" AND $tpl_pay_method != "Jet" AND $tpl_pay_method != "Walmart"}
				<tr id="row3">
					<td>Address</td>
					<td>City, State, Zip Code, Country</td>
				</tr>
{if (($tpl_shipadd1 == $tpl_add1) && ($tpl_shipadd2 == $tpl_add2) && ($tpl_shipcity == $tpl_city) && ($tpl_shipstate == $tpl_state) && ($tpl_shipzip == $tpl_zip) && ($tpl_shipcountry == $tpl_country))}
{assign var="td_bill_address_highlight_html" value=''}
{else}
{assign var="td_bill_address_highlight_html" value=' class="cellhighlight"'}
{/if}
				<tr id="row4">
					<td{$td_bill_address_highlight_html}>{$tpl_add1}<br />{$tpl_add2}</td>
					<td{$td_bill_address_highlight_html}>{$tpl_city}, {$tpl_state}&nbsp;&nbsp;{$tpl_zip}
{if ($tpl_country != "US")}<br />{$tpl_country}{/if}
					</td>
				</tr>
{/if}
				<tr id="row3">
					<td>Day Phone</td>
					<td>Night Phone</td>
				</tr>
				<tr id="row4">
{if $tpl_day_phone == ""}
					<td>&nbsp;</td>
{else}
					<td>{$tpl_day_phone}</td>
{/if}
					<td>{$tpl_nite_phone}</td>
				</tr>
{if $tpl_show_ven == TRUE}
				<tr/>
{else}
				<tr id="row3">
					<td colspan="2">Email Address</td>
				</tr>
				<tr id="row4">
					<td colspan="2">{$tpl_email|lower}</td>
				</tr>
{/if}
			</table>
		</fieldset>
	<div class="row">
		<br />
		<fieldset id="left">
			<legend>Shipping Information</legend>
			<table class="table1">
				<tr id="row3">
					<td width="30%">Shipping Method</td>
					<td width="35%" class="row4"{if $tpl_shpng_method != "Standard"} class="cellhighlight"{/if}>{$tpl_shpng_method}</td>
				</tr>
				<tr id="row3">
					<td>Ship To</td>
					<td class="row4">{$tpl_shipname}</td>
				</tr>
				<tr id="row3">
					<td>Address</td>
					<td>City, State, Zip Code, Country</td>
				</tr>
{assign var="td_ship_address_first_char" value=$tpl_shipadd1|trim|truncate:1:""}
				<tr id="row4">
					<td{if (($td_ship_address_first_char < '1') || ($td_ship_address_first_char > '9'))} class="cellhighlight"{/if}>{$tpl_shipadd1}<br />{$tpl_shipadd2}</td>
					<td>{$tpl_shipcity}, {$tpl_shipstate}&nbsp;&nbsp;{$tpl_shipzip}
{if ($tpl_shipcountry != "US")}<br />{$tpl_shipcountry}{/if}
					</td>
				</tr>
				<tr id="row3">
					<td colspan="2">Special Instructions to Vendor</td>
				</tr>
				<tr id="row4">
{if $tpl_special_instr != "" }
					<td colspan="2" class="cellhighlight">{$tpl_special_instr}</td>
{else}
					<td colspan="2">&nbsp;</td>
{/if}
				</tr>
			</table>
		</fieldset>
	</div>
	<div class="row">
		<fieldset>
			<legend>Order Line Items</legend>
			<table id="table2">
				<tr valign="top">
					<th></th>
					<th>Vendor</th>
					<th>Vendor SKU</th>
					<th>Item<br />
					  (Pink line: vendor = NO or xx)
					</th>
					<th>Qty Sold</th>
					<th>Status</th>
					<th>Ship Mode</th>
					<th>Tracking #</th>
					<th>Shipped Date</th>
				</tr>
{assign var=radio_flag value='false'}
{section name=lineitems loop=$tpl_order_details}
{if $tpl_order_details[lineitems].internal == 1}
				<tr valign="top" class="row6">
					<td class="radio_class" id="radio_class">
					{if $tpl_order_details[lineitems].quantity > 1}
						{if $radio_flag == "false"}
							<input type="radio" name="line_item" id="line_item" value="{$tpl_order_details[lineitems].mSku}" checked onclick="handleClick(this);"/>
							{assign var=radio_flag value='true'}
						{else}
							<input type="radio" name="line_item" id="line_item" value="{$tpl_order_details[lineitems].mSku}" onclick="handleClick(this);" />
						{/if}	
					{/if}
					</td>	
					<td>
					<a href="http://{$smarty.server.SERVER_NAME}/search/?q={$tpl_order_details[lineitems].sku}" target="_new">{$tpl_order_details[lineitems].sku}</a>
					</td>
					<td>&nbsp;
					</td>
					<td>{$tpl_order_details[lineitems].item_description}</td>
					<td class="quantity_class" >{$tpl_order_details[lineitems].quantity}</td>
					<td>{$tpl_order_details[lineitems].item_status}</td>
					<td class="cellNa">&nbsp;</td>
					<td class="cellNa"></td>
					<td class="cellNa"></td>
					<td class="cellNa"></td>
					<td class="cellNa"></td>
				</tr>
{else}
				<tr valign="top" class="row6> {if $tpl_order_details[lineitems].internal == 0} vendorSku{/if}{if $tpl_order_details[lineitems].flag_do_not_pay == 1} do-not-pay{/if}">
{if $tpl_order_details[lineitems].highlight_line_item == TRUE}
{assign var="td_highlight_html" value=' class="cellhighlight"'}
{else}
{assign var="td_highlight_html" value=''}
{/if}									
					<td class="radio_class" id="radio_class">
					<!-- Show radio button only when the quantity is higher than 1-->
					{if $tpl_order_details[lineitems].quantity > 1} 
						{if $radio_flag == "false"}
							<input type="radio" name="line_item" id="line_item" value="{$tpl_order_details[lineitems].mSku}" checked onclick="handleClick(this);"/>
							{assign var=radio_flag value='true'}
						{else}	
						<input type="radio" name="line_item" id="line_item" value="{$tpl_order_details[lineitems].mSku}" onclick="handleClick(this);" />
						{/if}
					{/if}
					</td>	
					<td>{$tpl_order_details[lineitems].vendorCode}</td>
{if $tpl_order_details[lineitems].back_order_flag == TRUE}
					<td id="backorderhighlight">
{elseif $tpl_order_details[lineitems].vendor_fk == 185}
					<td style="background-color: #BDE5F8;">
{elseif $tpl_order_details[lineitems].flag_auto_place_failure == TRUE}
					<td id="autoplacefailurehighlight">
{elseif $tpl_order_details[lineitems].sku=="WH1753BG"}
					<td id="addpromocodehighlight">
{else}
					<td{$td_highlight_html}>
{/if}
						<a href="http://{$smarty.server.SERVER_NAME}/search/?q={$tpl_order_details[lineitems].mSku}" target="_new">{$tpl_order_details[lineitems].mSku}</a>
					</td>
					<td>{$tpl_order_details[lineitems].item_description}</td>
					<td class="quantity_class">{$tpl_order_details[lineitems].quantity}</td>
					<td>{$tpl_order_details[lineitems].item_status}</td>
					<td>{$tpl_order_details[lineitems].shipping_mode}</td>
{if $tpl_order_details[lineitems].shipping_tracking_no == ""}
					<td>&nbsp;</td>
{else}
					<td>{$tpl_order_details[lineitems].shipping_tracking_no}</td>
{/if}
{if $tpl_order_details[lineitems].shipped_date == "0000-00-00"}
{if $tpl_order_details[lineitems].estimated_shipped_date == "0000-00-00"}
					<td>&nbsp;</td>
{else}
					<td{if $tpl_order_details[lineitems].back_order_flag == TRUE} id="backorderhighlight"{/if}{if $tpl_order_details[lineitems].line_item_overdue} style="color: red;"{/if}>{$tpl_order_details[lineitems].estimated_shipped_date|date_format:"%D"}</td>
{/if}
{else}
					<td>{$tpl_order_details[lineitems].shipped_date|date_format:"%D"}</td>
					</tr>
					</table>
{/if}
{/if}
{/section}
		</fieldset>
		<table>
		<tr>
		<td><label for="new_quantity">Enter New Quantity</label></td>
		<td><input type="number" id="split_quantity" name="split_quantity" min="1" max="6"></td>
		<td><button type="submit" value="Save" name="submit_action">Submit</button></td>
		<td><button type="submit" value="Cancel" name="submit_action">Cancel</button></td>
		</tr>
		</table>
		</div>
</div><!-- end of col3-->
</form>
{literal}
<script>
$(function() {
	$("#messages tr").bind("click", function() {
		var id = $(this).attr('num');

		$("#message"+id).dialog('open');
	});

	$(".messageDetail").dialog({
		autoOpen: false,
		width: '700px',
		modal: true
	});
});

function check_radio_and_validate_quantity() {
	if (!document.getElementById('line_item').checked) {
		alert("Please select the line item to split!");
		return false;
	} else if (document.forms["split_line_item"]["split_quantity"].value == null || document.forms["split_line_item"]["split_quantity"].value == "" ) {
		alert("Please enter the quantity to split!");
		return false;
	}
	return true;
}

$( document ).ready(function() {
	var firstRadioValue = 0;
	firstRadioValue = $("input[name='line_item']:checked").val();
	$('input[name="split_quantity"]').attr('max', firstRadioValue);
	var quantity = $(".radio_class").closest('tr').find(".quantity_class").val();
	alert(quantity);
});

var currentRadioValue = 0;
function handleClick(line_item) {
    alert('New value: ' + line_item.value);
    currentRadioValue = line_item.value;
	$('input[name="split_quantity"]').attr('max', currentRadioValue);
}
</script>
{/literal}
{include file="footer.tpl"}
