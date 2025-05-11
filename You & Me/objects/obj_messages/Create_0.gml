elijah = [];
rory = [];
jonah = [];
evelyn = [];
dawn = [];
trent = [];
group = [];
jesse = [];
kellen = [];
contacts = [[elijah, "Elijah"], [rory, "Rory"], [jonah, "Jonah"], [evelyn, "Evelyn"],
[dawn, "Dawn"], [trent, "Trent"], [group, "Group"], [jesse, "Jesse"], [kellen, "Kellen"]];
//array name, string name in file, currently selected, accessible, current message y position, string name to display

data = get_contacts_data();
for (var _i = 0; _i < array_length(data); _i++) {
	if data[_i][0] = contacts[_i][1] {
		array_push(contacts[_i], data[_i][1], data[_i][2], data[_i][3], data[_i][4]);	
	};
};

print(contacts)

window_message_y = 0;
targ = "";

contact_message_y = 0; 

depth = -999