﻿--[=======[
-------- -------- -------- --------
  Tencent SSO 2  >>>> TLV >>>> 0114
-------- -------- -------- --------

SSO2::TLV_DHParams_0x114
]=======]

local dissectors = require "TXSSO2/Dissectors";

dissectors.tlv = dissectors.tlv or {};

dissectors.tlv[0x0114] = function( buf, pkg, root, t, off, size )
  local oo = off;
  local ver = buf( off, 2 ):uint();
  if ver == 0x0102 then
    off = dissectors.add( t, buf, off,
      ">wTlvVer W",
      ">bufDHPublicKey",  FormatEx.wxline_bytes
      );
  end
  dissectors.addex( t, buf, off, size - ( off - oo ) );
end