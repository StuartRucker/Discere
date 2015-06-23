var ref = new Firebase("https://discere.firebaseio.com")


ref.on('child_added', function(childSnapshot, prevChildKey) {
    var name = childSnapshot.child("name").val()
    if (name != "") {
        $('#mytable').append('<tr><td>' + 'name: ' + name + '</td></tr>');
    }
    // code to handle new child.
    //alert("lmao")
});

function handleClick() {
    var childRef = ref.push()
    childRef.set({
        'name': document.getElementById("nameInput").value
    })
    alert("successful?");

}