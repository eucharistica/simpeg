(function(){
  async function j(url){
    const r = await fetch(url, {credentials:'include'});
    if(!r.ok) throw new Error('HTTP '+r.status);
    const js = await r.json();
    if(!js.ok) throw new Error(js.error||'api_error');
    return js.data;
  }

  async function load(){
    // Poliklinik
    try{
      const rows = await j('/api/simrs/clinics.php');
      const tb = document.querySelector('#tbl-poli tbody');
      if (tb) {
        tb.innerHTML='';
        rows.forEach(x=>{
          const tr=document.createElement('tr');
          tr.innerHTML = `<td>${x.kd_poli}</td><td>${x.nm_poli}</td><td>${x.status=='1'?'Aktif':'Nonaktif'}</td>`;
          tb.appendChild(tr);
        });
      }
    }catch(e){ console.error(e); }

    // Dokter
    try{
      const rows = await j('/api/simrs/doctors.php');
      const tb = document.querySelector('#tbl-dokter tbody');
      if (tb) {
        tb.innerHTML='';
        rows.forEach(x=>{
          const tr=document.createElement('tr');
          tr.innerHTML = `<td>${x.kd_dokter}</td><td>${x.nm_dokter}</td><td>${x.jk||''}</td>`;
          tb.appendChild(tr);
        });
      }
    }catch(e){ console.error(e); }
  }
  document.addEventListener('DOMContentLoaded', load);
})();