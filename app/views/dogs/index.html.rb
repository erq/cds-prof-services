<!-- <div class="large-12 columns"> -->
  <%= form_tag dogs_path, :method => :get do %>

  <div class="large-12 columns">
        <div class="large-6 columns">
        <div class="row">
            <div class="large-4 columns" style="text-align:center">
              Age:
              <br />
              <div class="tiny ui vertical buttons">
              <% Dog.age_ranges.each_with_index do |a, i| %>
              <div class="ui button">
              <%= check_box_tag "age[#{i}]", 1, @form_filler.values[:age].include?(i.to_s), :class => "check" %>
              <%= label(:age, i, a) %>
              </div>
              <% end %>
              </div>
            </div>

            <div class="large-3 columns" style="text-align:center">
              Gender:
              <br />
              <div class="tiny ui vertical buttons">
              <% Dog.genders.each do |gender| %>
              <div class="ui button">
              <%= check_box_tag "gender[#{gender}]", 1, @form_filler.values[:gender].include?(gender), :class => "check" %>
              <%= label(:gender, gender.tr(" ", "_"), gender) %>
              </div>
              <% end %>
              </div>
            </div>

            <div class="large-5 columns" style="text-align:center">
              Size:
              <br />
              <div class="tiny ui vertical buttons">
              <% Size.all_values.each do |s| %>
              <div class="ui button">
              <%= check_box_tag "size[#{s}]", 1, @form_filler.values[:size].include?(s), :class => "check" %>
              <%= label(:size, s.tr(" ", "_"), s) %>
              </div>
              <% end %>
              </div>
            </div>
        </div>
        <div class = "row">
            <br>
            

            <div style="text-align:center">
            <!--<%= label(:radius, "Dogs Within") %>-->
            Dogs within <%= text_field_tag(:radius, @form_filler.values[:radius], :size => 10  )%> miles of zipcode   
            <!--<%= label(:zipcode, "of") %>-->
            <%= text_field_tag(:zipcode, @form_filler.values[:zipcode], :size => 7) %>
      </div>
                Mix:
                <%= select_tag 'mix', options_for_select(["All Mixes"] + Mix.all_values, @form_filler.values[:mix]) %>
        </div>
    </div>
    <!-- </div> -->
    <div class="large-6 columns" style="text-align:center">
        <div class="large-4 columns">
          Personality:
          <br />
          <div class="mini ui vertical buttons">
          <% Personality.all_values.each do |p| %>
          <div class="ui button">
            <%= check_box_tag "personality[#{p}]", 1, @form_filler.values[:personality].include?(p), :class => "check" %>
            <%= label(:personality, p.tr(" ", "_"), p) %>
          </div>
          <% end %>
        </div>
    </div>
            <div class="large-3 columns" style="text-align:center">
          Energy:
          <br />
          <div class="mini ui vertical buttons">
          <% EnergyLevel.all_values.each do |e| %>
          <div class="ui button">
          <%= check_box_tag "energy_level[#{e}]", 1, @form_filler.values[:energy_level].include?(e), :class => "check" %>
          <%= label(:energy_level, e.tr(" ", "_"), e) %>
          </div>
          <% end %>
        </div>
        </div>

        <div class="large-5 columns" style="text-align:center">
          Likes:
          <br />
          <div class="mini ui vertical buttons">
          <% Like.all_values.each do |l| %>
          <div class="ui button">
          <%= check_box_tag "like[#{l}]", 1, @form_filler.values[:like].include?(l), :class => "check" %>
          <%= label(:like, l.tr(" ", "_"), l) %>
          </div>
          <% end %>
        </div>
        <br>
        <br>
      <div style="margin-left: -6em">
        <%= submit_tag 'Search Dogs', :id => 'dog_search_submit', :class => "ui primary button large transparent input" %>
      </div>
    </div>
    
    </div>
  <% end %>

<span id="zipcodes" data-zipcodes="<%= @zipcodes %>"/>
  <span id="counts" data-counts="<%= @counts %>"/>
  
  <div class="large-7 columns" >
    <br>
    <div class="ui segment" id="dog_search_results" style="padding: 0em">

    <% if @no_dogs %>
      <h1> No Dogs Found </h1>
    <% end %>
    <% @dogs.each do |dog| %>
    <% if dog.future_events? %>
    <div class="ui vertical segment" style="padding: 1em; border-style: solid; border-width: 1px; border-color: #5bbd72; border-radius: 3px" id = <%= dog.owner.zipcode %> >
    <div class="ui green bottom right attached right label" style="border-radius:0">Looking for a sitter!</div>

    <% else %>
    <div class="ui vertical segment" style="padding: 1em" id = <%= dog.owner.zipcode %> >
    <% end %>

      <div class="large-3 columns" style="padding: 0">
        <!-- <span class="image"> -->
          <div id="photo"><% if dog.photo.file? %>
          <%= image_tag dog.photo.url(:medium) %>
        <% else %>
          <%= image_tag "default_dog.jpg" %>
        <% end %></div>
        <!-- </span> -->
      </div>

      <div class="large-9 columns" style="padding-right: 0">
        <div class="content">
          <div class="ui medium header" style="margin-bottom: 0">
            <%= link_to dog.name, dog_path(dog) %>  
          <% if not current_user.nil? %>
          <span class="right floated stars">
            <%- unless current_user.starred_dogs.exists?(id: dog.id) -%>
              <%= link_to starred_dogs_path(dog_id: dog), method: :post, id: "star_#{dog.id}" do%>
              <i class="empty icon yellow large" style="margin-right: -0.3em"><%= dog.stars.count %></i><i class="empty star icon yellow large"></i>
              <%end%>
            <%- else -%>
              <%= link_to starred_dogs_path(dog_id: dog), method: :delete, id: "star_#{dog.id}" do%>
              <i class="icon yellow large" style="margin-right: -0.3em"><%= dog.stars.count %></i><i class="star icon yellow large"></i>
              <%end%>
            <%- end -%>
          </span>
          <%end%>
          </div>
          <div class="age">
            <b><%= dog.age_caption %></b>
          </div>
          <span class="right floated" style="margin-right: 5%">
            <%= dog.owner.zipcode %>
          </span>
          <div class="attributes">
            <b><%= dog.tags %></b>
          </div>
          <div class="description">
            <%= dog.motto %>
          </div>
        </div>
        <div class="extra content">
          <% unless dog.availability == "" %>
          <i class="wait icon"></i>
          <%= dog.availability %>
          <% end %>
        </div>
        <% if dog.future_events? %>
        <b>Next event:</b> <%= dog.future_events.first.start_date.strftime("%m/%d/%Y") %>
        <% end %>
      </div>

    </div>
    <% end %>
    </div>
  </div>

#   <div class="large-5 columns" id="map">
#         <br>
#     <div class ="ui sticky">
#     <div id="map-canvas">
#       <!-- <img src="http://www.digicution.com/wp-content/uploads/2012/06/HTML5-Repsonsive-Google-Maps-Tutorial-1.png" style="height:100%; width:100%"> -->
#     </div></div>
#   </div>
# </div>

# <script type="text/javascript"
#   src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCvpxxyVWimCzY6WLJTY8iYGUUkVy6q7bA">
# </script>
# <script>
# $(document).ready(function(){
#   $('.ui.sticky')
#   .sticky({
#     offset: 50,
#     context: '#dog_search_results'
#   });

#   $('select.dropdown').dropdown(); 

#   var geocoder;
#   var map;
#   var query = $('#zipcodes').data('zipcodes');
#   var counts = $('#counts').data('counts');
#   //var query = ['2523 Ridge Road, Berkeley, CA', 'Berkeley'];
#   function initialize() {
#     geocoder = new google.maps.Geocoder();
#     var mapOptions = {
#       zoom: 8, 
#       streetViewControl: false,
#       zoomControl: true
#     }
#     map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
#     var bounds = new google.maps.LatLngBounds();
#     codeAddress(counts, bounds);
    
#   }

# //  Fit these bounds to the map

#   function codeAddress(counts, bounds) {
#     var address = query;
#     var visited = [];
    
#     for (i = 0; i < address.length; i++) {
        

#         if ($.inArray(address[i], visited) == -1) {
#             visited.push(address[i]);

#         geocoder.geocode( { 'address': address[i]}, function(results, status) {
#         if (status == google.maps.GeocoderStatus.OK) {
#           //map.setCenter(results[0].geometry.location);
#           var current = results[0].address_components[0].long_name;
          
#           var marker = new google.maps.Marker({
#               map: map,
#               icon: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld="+counts[current]+"%7CFE6256%7C000000",
#               url: '#' + current,
#               position: results[0].geometry.location
#           });
#           google.maps.event.addListener(marker, 'click', function() {
#             $('body').animate({scrollTop: $(marker.url).offset().top - 50}, 'slow');
#           });
#           bounds.extend(marker.getPosition());
#           map.fitBounds(bounds);

#         } 
#     });
#     }
# }

#   }

#   google.maps.event.addDomListener(window, 'load', initialize);
# });
</script>