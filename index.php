<?
error_reporting(E_ALL);
ini_set("display_errors", 1);
include_once("./lib/config.php");

$sql = "select * from repl_check";
$sql1 = "select * from fw_check";
$query = mysqli_query($con,$sql);
$query1 = mysqli_query($con,$sql1);
$date1 =  date("Ymd")
?>


<html>
<head>
<meta http-equiv="refresh" content="60">
<style>
th {text-align:center; background-color:#f4f4f4; border:1px solid #444444;padding-top:10px; padding-bottom:10px;}
td {text-align:center;border:1px solid #444444;height:30px}
h3 {text-align:center; color:red;}
a {text-decoration:none;}
.box {display:inline-block;;width:300px;height:50px;margin:1em;};
</style>
</head>

<body>
<center>
<div class="box">
<h1>REPLICATION</h1>
</div>
<div class="box">
<h3><?=date("Y-m-d")?></h3>
</div>
<br />
</center>
<table align="center" style="width:1400px;border:2px solid #444444;border-collapse:collapse;">


<tr>
  <th>AGENT</th>
  <th>HOST</th>
  <th>MASTER(IP)</th>
  <th>SLAVE(IP)</th>
  <th>MASTER(POS)</th>
  <th>SLAVE(POS)</th>
  <th>SLAVE(STAT)</th>
  <th>I/O STAT</th>
  <th>FILE_MASTER</th>
  <th>FILE_SLAVE</th>
  <th>ERR.No</th>
  <th>TIME</th>
</tr>

<?
while ($row = mysqli_fetch_array($query)) { ?>
<tr>
  <td <? if ($row["agent"] == "UP") { ?>style="background-color: white; color: green"<? } else { ?>style="background-color: white; color: red"<? } ?>><?=$row['agent']?> </td>
  <td><?=$row['host']?> </td>
  <td><?=$row['m_ip']?> </td>
  <td><?=$row['s_ip']?> </td>
<!--  <td><?=$row['mas_pos']?> </td>
  <td><?=$row['sla_pos']?> </td> -->
  <td <? if ($row["mas_pos"] == $row["sla_pos"]) { ?>style="background-color: white; color: black"<? } else { ?>style="background-color: white; color: black"<? } ?>><?=$row['mas_pos']?> </td>
  <td <? if ($row["sla_pos"] == $row["mas_pos"]) { ?>style="background-color: white; color: blue"<? } else { ?>style="background-color: white; color: red"<? } ?>><?=$row['sla_pos']?> </td>
  <td><?=$row['sla_stat']?> </td>
  <td <? if ($row["stat"] == "Yes") { ?> style="background-color: white; color: green" <? } else { ?> style="background-color: white; color: red" <? } ?>><?=$row['stat']?> </td>
  <td <? if ($row["fm"] == "SUCCESS") { ?>style="background-color: white; color: green"<? } else { ?>style="background-color: white; color: red"<? } ?>><?=$row['fm']?> </td>
  <td <? if ($row["fs"] == "SUCCESS") { ?>style="background-color: white; color: green"<? } else { ?>style="background-color: white; color: red"<? } ?>><?=$row['fs']?> </td>
  <td <? if ($row["errno"] == "0") { ?>style="background-color: white; color: black"<? } else { ?>style="background-color: white; color: red"<? } ?>><?=$row['errno']?> </td>
  <td><?=$row['time']?> </td>
</tr>
<? } ?>
</table>

<!--
<center>
<div class="box">
<h1>F/W BACKUP</h1>
</div>
<div class="box">
<h3><?=date("Y-m-d")?></h3>
</div>
</center>
<table align="center" style="width:1400px;border:2px solid #444444;border-collapse:collapse;">
<tr>
  <th>FILE COUNT</th>
  <th>CONFIG PERMIT</th>
  <th>LAST BACKUP</th>
</tr>

<?
while ($row = mysqli_fetch_array($query1)) { ?>
<tr>
  <td <? if ($row["config"] == "SUCCESS") { ?>style="background-color: white; color: green"<? } else { ?>style="background-color: white; color: red"<? } ?>><?=$row['config']?> </td>
  <td <? if ($row["permit"] == "SUCCESS") { ?>style="background-color: white; color: green"<? } else { ?>style="background-color: white; color: red"<? } ?>><?=$row['permit']?> </td>
  <td><?=$row['time']?> </td>
</tr>
<? } ?>
</table>
</body>
</html> -->
