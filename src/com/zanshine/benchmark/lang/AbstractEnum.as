/**
 * Copyright (C) 2009 Stéphane Robert Richard.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the project nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * 
 */
 package com.zanshine.benchmark.lang
{
	import com.zanshine.benchmark.error.ErrorMessages;
	import flash.errors.IllegalOperationError;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;


	/**
	 * Abstract Class
	 */
	public class AbstractEnum implements Enum
	{

		private var _identifier : String;

		public function get uid() : String
		{
            if(!_identifier)
				_identifier = getQualifiedClassName(this) + '$' + valueOf() + '#' + name;
			return _identifier;
		}

		private var _name : String;

		public function get name() : String
		{
			return _name;
		}
		
		private var _ordinal : uint;
		
		public function valueOf():Object
		{
			return _ordinal;
		}
		
		public function toString():String
		{
			return "[Enum " + uid + "]";
		}
		
		private static var count:int;
		
		/**
		 * @constructor 
		 * @param name The name of this instance
		 * 
		 */		
		public function AbstractEnum( key:Key, name:String = null )
		{
			if(key == null) 
        	{
        		throw new IllegalOperationError(ErrorMessages.ABSTRACT_ERROR);
        		return;
            }
			if(hasConst(this))
			{
				throw new IllegalOperationError(ErrorMessages.ILLEGAL_ENUM);
                return;
			}
			count++;
			_ordinal = count;
			_name = name ? name : _ordinal.toString();
		}
		
		/**
		 * Thanks to niko@informatif.org for tip
		 */
		protected static function hasConst (value:*) : Boolean
		{
			var c 	: Class = value is Class ? value as Class : getDefinitionByName(getQualifiedClassName(value)) as Class;
			var x 	: XML = describeType(c),
				node:XML,
				n 	: int = 0;
			for each (node in x.constant) n++;
			return n != 0;
		}
		
		private static var _constructorKey:Key;
        
        protected static function get contructorKey():Key
        {
            return _constructorKey = _constructorKey ? _constructorKey : new Key(); 
        }
    }
}

class Key { }