// an example map function, emits the doc id 
// and the list of keys it contains
// !code lib.helpers.math

function(doc) {
  if (doc.type == "Cause") {
    emit(null, doc);
  }
};
