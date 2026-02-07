/* index.js
Purpose:
This file will remove table row striping from gtsummary tables on output.

The row striping is not seen when the tables are ran as a cell within
in a normal Quarto document. Using this script matches the output
of the Quarto page to what's seen in the Viewer pane.
*/ 

document.addEventListener('DOMContentLoaded', function() {
  // Remove table-striped class from all tables
  document.querySelectorAll('.table-striped').forEach(function(table) {
    table.classList.remove('table-striped');
  });
  
  // Set max width for gt tables
  document.querySelectorAll('.gt_table').forEach(function(table) {
    table.style.maxWidth = '90%';
    table.style.margin = '0 auto';
  });

  // Set max width for regular tables
  document.querySelectorAll('table').forEach(function(table) {
    table.style.maxWidth = '90%';
    table.style.margin = '0 auto';
  });
});
