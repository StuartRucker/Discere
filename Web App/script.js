var ref = new Firebase("https://discere.firebaseio.com")


ref.on('child_added', function(childSnapshot, prevChildKey) {
    var name = childSnapshot.child("name").val()
    if (name != "") {
        //$('#mytable').append('<tr><td>' + 'name: ' + name + '</td></tr>').fadeIn(1000);
        $('<tr><td style: "{opacity: 0;}">' + ' ' + name + '</td></tr>').appendTo('#mytable').fadeOut(0).fadeIn(500);
    }

    // code to handle new child.
    //alert("lmao")
});

function handleClick() {
    var childRef = ref.push()
    if (document.getElementById("firstNameInput").value != "" || document.getElementById("lastNameInput").value != "") {
        childRef.set({
            'name': document.getElementById("firstNameInput").value + " " + document.getElementById("lastNameInput").value,
            'class': document.getElementById("classInput").value
        })
    }

}