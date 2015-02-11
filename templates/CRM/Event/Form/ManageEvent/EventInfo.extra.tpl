{if $smarty.get.cgcount gt '0'}
  <h2>Click any row below to populate Webinar Key.</h2><br />
  
  <table id="webinar_settings" cellspacing="0" width="100%" >
  
    <thead>
      <tr>
        <th>Description</th>
        <th>Subject</th>
        <th>Webinar Key</th>
        <th>Start Time</th>
        <th>End Time</th>
      </tr>
    </thead>
	
    <tbody>	
      {foreach from=$upcomingWebinars item=webinar}
      {assign var=times value=$webinar.times}
        <tr>
          <td style="cursor: pointer; sortable="true">{$webinar.description}</td>
          <td style="cursor: pointer; class='subject' sortable="true">{$webinar.subject}</td>
          <td class='webminarKey' sortable="true" style="cursor: pointer;" title="Click the key to populate Webinar Key.">{$webinar.webinarKey}</td>
          <td style="cursor: pointer; sortable="true">{$times[0].startTime|crmDate}</td>
          <td style="cursor: pointer; sortable="true">{$times[0].endTime|crmDate}</td>
        </tr>
      {/foreach}
    </tbody>	   
  </table>
	
  {literal} 
  <script> 
  
    cj(document).ready(function() {
	  cj(document).tooltip();		
	  cj().crmAPI ('CustomField','get',{'sequential' :'1', 'name' :'Webinar_id'},
	  {success:function (data){    
	    cj.each(data, function(key, value){
	    window.CusfieldId = data.id;});
	  }
      });
		
      var custom = "{/literal}{$customDataSubType}{literal}";
        if(custom){
          var webinar_settings = cj('#webinar_settings').html();
          webinar_settings = webinar_settings.replace("<tbody>", "");
          webinar_settings = webinar_settings.replace("</tbody>", ""); 
          cj("input[data-crm-custom='Webinar_Event:Webinar_id']").parent().parent().after(webinar_settings);
        }
		
      cj('#webinar_settings tbody').on('click', 'tr', function (){            
        var fieldname ='#custom_'+CusfieldId+'_-1';				
        var name = cj('td', this).eq(2).text();
	    cj(fieldname).val(name);
        });
    cj('#webinar_settings').dataTable();
    });
	
  </script>
  {/literal}
{/if}
