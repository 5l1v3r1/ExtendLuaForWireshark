﻿--[=======[
-------- -------- -------- --------
  Tencent SSO 2  >>>> KeyChain
-------- -------- -------- --------

新建全局函数TXSSO2_Add2KeyChain，用于向KeyChain添加命名的Key

返回常量表

KeyChain中的KeyName不允许重复
KeyChain中的Key参与解密时，无论长度如何，都将固定为0x10，长度不足，以\0补齐，长度过长，则截断
]=======]
local keychain = {};

--提供函数用于将KEY加入KeyChain
function TXSSO2_Add2KeyChain( key_name, key )
  if not key_name then
    return error( "加入KeyChain请指定KeyName" );
  end
  if type( key_name ) ~= "string" then
    return error( "加入KeyChain的KeyName必须为string类型" );
  end
  if keychain[ key_name ] then
    if keychain[ key_name ] ~= key then
      return error( "加入KeyChain时KeyName[" .. key_name .. "]重复" );
    else
      return;
    end
  end
  if type( key ) ~= "string" then
    return error( "加入KeyChain的Key必须为string类型" );
  end
  keychain[ key_name ] = key;
end

function TXSSO2_MakeKeyName( CsCmdNo, Seq, FrameNum )
  return string.format( "c%04Xs%04Xf%d", CsCmdNo, Seq, FrameNum );
end

function TXSSO2_AnalysisKeyName( KeyName )
  return KeyName:match( "c(%x%x%x%x)s(%x%x%x%x)f(%d+)" );
end

local keys = require "TXSSO2/ECDHKey";
local sharekey, privatekey = unpack( keys );

TXSSO2_Add2KeyChain( "Default ECDH Share Key", sharekey );
TXSSO2_Add2KeyChain( "Default ECDH Private Key", privatekey );

return setmetatable(
  {},
  {
  __index = keychain;
  __pairs = function( t )
    return next, keychain, nil;
  end;
  __newindex = function()
    return error( "KeyChain禁止外部修改，请使用[TXSSO2_Add2KeyChain]函数添加" );
  end;
  }
  );